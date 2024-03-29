﻿using AutoMapper;
using eAutoSalon.Models.InsertRequests;
using eAutoSalon.Models.SearchObjects;
using eAutoSalon.Models.UpdateRequests;
using eAutoSalon.Models.ViewModels;
using eAutoSalon.Services.Database;
using eAutoSalon.Services.Interfaces;
using Microsoft.EntityFrameworkCore;
using Microsoft.ML.Data;
using Microsoft.ML.Trainers;
using Microsoft.ML;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.ConstrainedExecution;
using Microsoft.ML.Transforms;

namespace eAutoSalon.Services.Services
{

    public class AutomobilService : BaseCRUDService<VMAutomobil, Automobili, AutomobilSearchObject, AutomobilInsert, AutomobilUpdate>, IAutomobilService
    {
        public AutomobilService(EAutoSalonTestContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<Automobili> AddFilter(IQueryable<Automobili> query, AutomobilSearchObject? search = null)
        {
            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                query = query.
                    Where(x => search.FTS.Contains(x.Boja) ||
                    search.FTS.Contains(x.GodinaProizvodnje.ToString()) ||
                    search.FTS.Contains(x.VrstaGoriva) ||
                    search.FTS.Contains(x.PredjeniKilometri.ToString()));
            }
            return query;
        }

        public override IQueryable<Automobili> Order(IQueryable<Automobili> query)
        {
            query = query.OrderByDescending(x => x.AutomobilId);
            return query;
        }

        public async Task<List<string>> GetProizvodjace()
        {
            var list = new List<string>
            {
                "Svi"
            };
            var proizvodjaci = await _context.Automobilis.Where(x => x.State == "Aktivan").Select(p => p.Proizvodjac).Distinct().ToListAsync();
            foreach (var item in proizvodjaci)
            {
                list.Add(item);
            }

            return list;
        }

        public override async Task<VMAutomobil> Insert(AutomobilInsert req)
        {
            Automobili entity = new();

            _mapper.Map(req, entity);
            if (!string.IsNullOrEmpty(req?.slikaBase64)) { entity.Slika = Convert.FromBase64String(req.slikaBase64); }
            entity.DatumObjave = DateTime.Now;
            entity.State = "Aktivan";
            await _context.AddAsync(entity);
            await _context.SaveChangesAsync();

            return _mapper.Map<VMAutomobil>(entity);
        }


        public double CalculateCosineSimilarity(Automobili product1, Automobili product2)
        {
            double[] vector1 = new double[] { product1.GodinaProizvodnje, product1.BrojVrata, product1.PredjeniKilometri, (double)product1.Cijena!, ConvertToDouble(product1.VrstaGoriva) };
            double[] vector2 = new double[] { product2.GodinaProizvodnje, product2.BrojVrata, product2.PredjeniKilometri, (double)product2.Cijena!, ConvertToDouble(product2.VrstaGoriva) };

            double dotProduct = vector1.Zip(vector2, (a, b) => a * b).Sum();

            double magnitude1 = Math.Sqrt(vector1.Sum(x => x * x));
            double magnitude2 = Math.Sqrt(vector2.Sum(x => x * x));

            if (magnitude1 == 0 || magnitude2 == 0)
                return 0;
            else
                return dotProduct / (magnitude1 * magnitude2);
        }

        public List<Automobili> GetTopSimilarProducts(Automobili selectedProduct, List<Automobili> allProducts, int topN = 3)
        {
            var similarities = new Dictionary<Automobili, double>();

            foreach (var product in allProducts)
            {
                if (product != selectedProduct)
                {
                    double similarity = CalculateCosineSimilarity(selectedProduct, product);
                    similarities.Add(product, similarity);
                }
            }

            return similarities.OrderByDescending(kv => kv.Value).Take(topN).Select(kv => kv.Key).ToList();
        }

        private double ConvertToDouble(string vrijednost)
        {
            if (vrijednost == "Dizel")
                return 1.0;
            else if (vrijednost == "Benzin")
                return 0.0;
            else
                return 0.5;
        }


        public async Task<PagedList<VMAutomobil>> GetAktivne(AutomobilSearchObject? search = null)
        {
            var query = _context.Automobilis.Where(x => x.State == "Aktivan").OrderByDescending(x => x.AutomobilId).AsQueryable();

            var list = new PagedList<VMAutomobil>()
            {
                PageCount = await query.CountAsync(),
            };

            if (search?.PageSize != null)
            {
                double? pageCount = list.PageCount;
                double? pageSize = search.PageSize;
                if (pageCount.HasValue && pageSize.HasValue)
                {
                    list.TotalPages = (int)Math.Ceiling(pageCount.Value / pageSize.Value);
                }
            }

            if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
            {
                query = query.Skip(search.PageSize.Value * (search.Page.Value - 1)).Take(search.PageSize.Value);
                list.HasNext = search.Page.Value < list.TotalPages;
            }

            var lista = await query.ToListAsync();

            list.List = _mapper.Map<List<VMAutomobil>>(lista);

            return list;
        }



        public async Task<PagedList<VMAutomobil>> GetProdane(AutomobilSearchObject? search = null)
        {
            var query = _context.Automobilis.Where(x => x.State == "Prodano").OrderByDescending(x => x.AutomobilId).AsQueryable();



            var list = new PagedList<VMAutomobil>()
            {
                PageCount = await query.CountAsync(),
            };

            if (search?.PageSize != null)
            {
                double? pageCount = list.PageCount;
                double? pageSize = search.PageSize;
                if (pageCount.HasValue && pageSize.HasValue)
                {
                    list.TotalPages = (int)Math.Ceiling(pageCount.Value / pageSize.Value);
                }
            }

            if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
            {
                query = query.Skip(search.PageSize.Value * (search.Page.Value - 1)).Take(search.PageSize.Value);
                list.HasNext = search.Page.Value < list.TotalPages;
            }

            var lista = await query.ToListAsync();

            list.List = _mapper.Map<List<VMAutomobil>>(lista);

            return list;
        }



        public async Task<PagedList<VMAutomobil>> GetFiltered(AutomobilSearchObject? search = null)
        {
            var query = _context.Automobilis.Where(x => x.State == "Aktivan").OrderByDescending(x => x.AutomobilId).AsQueryable();

            if (!string.IsNullOrWhiteSpace(search?.Proizvodjac))
            {
                if (search.Proizvodjac != "Svi")
                {
                    query = query.Where(x => x.Proizvodjac == search.Proizvodjac);
                }
            }

            if (!string.IsNullOrWhiteSpace(search?.TipGoriva))
            {
                if (search.TipGoriva != "Svi")
                {
                    query = query.Where(x => x.VrstaGoriva == search.TipGoriva);
                }
            }

            if (search?.PredjenaKilometraza.HasValue == true)
            {
                query = query.Where(x => x.PredjeniKilometri < search.PredjenaKilometraza);
            }

            if (search?.BrojVrata.HasValue == true)
            {
                query = query.Where(x => x.BrojVrata == search.BrojVrata);
            }

            if (search?.GodinaProizvodnje.HasValue == true)
            {
                query = query.Where(x => x.GodinaProizvodnje < search.GodinaProizvodnje);
            }

            var list = new PagedList<VMAutomobil>()
            {
                PageCount = await query.CountAsync(),
            };

            if (search?.PageSize != null)
            {
                double? pageCount = list.PageCount;
                double? pageSize = search.PageSize;
                if (pageCount.HasValue && pageSize.HasValue)
                {
                    list.TotalPages = (int)Math.Ceiling(pageCount.Value / pageSize.Value);
                }
            }

            if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
            {
                query = query.Skip(search.PageSize.Value * (search.Page.Value - 1)).Take(search.PageSize.Value);
                list.HasNext = search.Page.Value < list.TotalPages;
            }

            var lista = await query.ToListAsync();

            list.List = _mapper.Map<List<VMAutomobil>>(lista);

            return list;
        }

        public async Task<int> GetUkupanBrojAktivnihOglasa()
        {
            int total = 0;
            var count = await _context.Automobilis.Where(x => x.State == "Aktivan").CountAsync();
            if (count != 0)
            {
                total = count;
            }
            return total;
        }

        static MLContext mlContext = null;
        static object isLocked = new object();
        static ITransformer model = null;
        public List<VMAutomobil> Recommend(int userId)
        {
            lock (isLocked)
            {
                if (mlContext == null)
                {
                    mlContext = new MLContext();

                    var testDrives = _context.TestnaVoznjas.Include(x => x.Automobil).ToList();

                    if (testDrives.Count == 0)
                    {
                        return new List<VMAutomobil>();
                    }

                    var data = new List<UserItemEntry>();

                    foreach (var x in testDrives)
                    {
                        data.Add(new UserItemEntry()
                        {
                            UserId = (uint)x.KorisnikId,
                            ItemId = (uint)x.AutomobilId,
                            Rating = 1
                        });
                    }

                    var trainData = mlContext.Data.LoadFromEnumerable(data);

                    MatrixFactorizationTrainer.Options options = new MatrixFactorizationTrainer.Options();
                    options.MatrixColumnIndexColumnName = nameof(UserItemEntry.UserId);
                    options.MatrixRowIndexColumnName = nameof(UserItemEntry.ItemId);
                    options.LabelColumnName = "Rating";
                    options.LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass;
                    options.Alpha = 0.01;
                    options.Lambda = 0.025;
                    options.NumberOfIterations = 100;
                    options.C = 0.00001;

                    var est = mlContext.Recommendation().Trainers.MatrixFactorization(options);

                    model = est.Fit(trainData);
                }
            }

            var cars = _context.Automobilis.Where(x=> x.State == "Aktivan" && !_context.TestnaVoznjas.Any(y => y.KorisnikId == userId && y.AutomobilId == x.AutomobilId)).ToList();

            var predictionResult = new List<Tuple<Automobili, float>>();

            foreach (var car in cars)
            {
                var predictionEngine = mlContext.Model.CreatePredictionEngine<UserItemEntry, UserBasedPrediction>(model);
                var prediction = predictionEngine.Predict(
                    new UserItemEntry()
                    {
                        UserId = (uint)userId,
                        ItemId = (uint)car.AutomobilId
                    });

                predictionResult.Add(new Tuple<Automobili, float>(car, prediction.Score));
            }

            var finalResult = predictionResult.OrderByDescending(x => x.Item2).Select(y => y.Item1).Take(3).ToList();

            return _mapper.Map<List<VMAutomobil>>(finalResult);
        }

        public class UserItemEntry
        {
            [KeyType(count: 10)]
            public uint UserId { get; set; }

            [KeyType(count: 10)]
            public uint ItemId { get; set; }

            public float Rating { get; set; }
        }

        public class UserBasedPrediction
        {
            public float Score { get; set; }
        }
    }
}
