using eAutoSalon.Models.SearchObjects;
using eAutoSalon.Models.ViewModels;
using eAutoSalon.Services;
using eAutoSalon.Services.Auth;
using eAutoSalon.Services.Database;
using eAutoSalon.Services.Interfaces;
using eAutoSalon.Services.Services;
using eAutoSalon_API.Filters;
using Microsoft.AspNetCore.Authentication;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers(x =>
{
    x.Filters.Add<ErrorFilter>();
});
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.AddSecurityDefinition("basicAuth", new Microsoft.OpenApi.Models.OpenApiSecurityScheme()
    {
        Type = Microsoft.OpenApi.Models.SecuritySchemeType.Http,
        Scheme="basic"
    });

    c.AddSecurityRequirement(new Microsoft.OpenApi.Models.OpenApiSecurityRequirement()
    {
        {
        new OpenApiSecurityScheme
        {
            Reference=new OpenApiReference{Type=ReferenceType.SecurityScheme,Id="basicAuth"}
        },
        new string[]{}
        }
    });
});


builder.Services.AddTransient<IKorisnikService, KorisnikService>();
builder.Services.AddTransient<IAutomobilService, AutomobilService>();
builder.Services.AddTransient<IUlogeService, UlogeService>();
builder.Services.AddTransient<IKomentarService, KomentarService>();
builder.Services.AddTransient<INovostService, NovostService>();
builder.Services.AddTransient<IMailService, MailService>();
builder.Services.AddTransient<IUposlenikService, UposlenikService>();
builder.Services.AddTransient<IOpremaService, OpremaService>();
builder.Services.AddTransient<ITestnaVoznjaService, TestnaVoznjaService>();
builder.Services.AddTransient<IRecenzijaService, RecenzijaService>();
builder.Services.AddTransient<IZavrseniService, ZavrseniService>();
builder.Services.AddTransient<ITransakcijaService, TransakcijaService>();

builder.Services.AddAutoMapper(typeof(Profiles));
builder.Services.AddAuthentication("BasicAuthentication").AddScheme<AuthenticationSchemeOptions, BasicAuth>("BasicAuthentication", null);


var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<EAutoSalonTestContext>(options =>
{
    options.UseSqlServer(connectionString);
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();
