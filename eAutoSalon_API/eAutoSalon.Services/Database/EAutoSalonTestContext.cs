﻿using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace eAutoSalon.Services.Database;

public partial class EAutoSalonTestContext : DbContext
{
    public EAutoSalonTestContext()
    {
    }

    public EAutoSalonTestContext(DbContextOptions<EAutoSalonTestContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Automobili> Automobilis { get; set; }

    public virtual DbSet<DodatnaOprema> DodatnaOpremas { get; set; }

    public virtual DbSet<Komentari> Komentaris { get; set; }

    public virtual DbSet<Korisnici> Korisnicis { get; set; }

    public virtual DbSet<KorisnikUloge> KorisnikUloges { get; set; }

    public virtual DbSet<Novosti> Novostis { get; set; }

    public virtual DbSet<Recenzije> Recenzijes { get; set; }

    public virtual DbSet<TestnaVoznja> TestnaVoznjas { get; set; }

    public virtual DbSet<Transakcije> Transakcijes { get; set; }

    public virtual DbSet<Uloge> Uloges { get; set; }

    public virtual DbSet<Uposlenici> Uposlenicis { get; set; }

    public virtual DbSet<ZavrseniPoslovi> ZavrseniPoslovis { get; set; }


    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Automobili>(entity =>
        {
            entity.HasKey(e => e.AutomobilId).HasName("PK__Automobi__BCB35E43F064A783");

            entity.ToTable("Automobili");

            entity.Property(e => e.AutomobilId).HasColumnName("AutomobilID");
            entity.Property(e => e.Boja).HasMaxLength(200);
            entity.Property(e => e.BrojSasije)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.Cijena).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.DatumObjave).HasColumnType("datetime");
            entity.Property(e => e.Model)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasDefaultValueSql("('not_defined')");
            entity.Property(e => e.Proizvodjac)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasDefaultValueSql("('not_defined')");
            entity.Property(e => e.SnagaMotora)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.State)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasDefaultValueSql("('Prodano')");
            entity.Property(e => e.VrstaGoriva)
                .HasMaxLength(100)
                .IsUnicode(false);
        });

        modelBuilder.Entity<DodatnaOprema>(entity =>
        {
            entity.HasKey(e => e.OpremaId).HasName("PK__DodatnaO__5C2EDCF157A6BC46");

            entity.ToTable("DodatnaOprema");

            entity.Property(e => e.OpremaId).HasColumnName("OpremaID");
            entity.Property(e => e.Abskocinice).HasColumnName("ABSKocinice");
            entity.Property(e => e.AutomobilId).HasColumnName("AutomobilID");
            entity.Property(e => e.StartStop).HasColumnName("Start_Stop");
            entity.Property(e => e.Usbport).HasColumnName("USBPort");

            entity.HasOne(d => d.Automobil).WithMany(p => p.DodatnaOpremas)
                .HasForeignKey(d => d.AutomobilId)
                .HasConstraintName("FK__DodatnaOp__Autom__4F47C5E3");
        });

        modelBuilder.Entity<Komentari>(entity =>
        {
            entity.HasKey(e => e.KomentarId).HasName("PK__Komentar__C0C304BC315EAC2A");

            entity.ToTable("Komentari");

            entity.Property(e => e.KomentarId).HasColumnName("KomentarID");
            entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");
            entity.Property(e => e.NovostiId).HasColumnName("NovostiID");
            entity.Property(e => e.Sadrzaj).HasColumnType("text");
            entity.Property(e => e.State)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasDefaultValueSql("('Aktivan')");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Komentaris)
                .HasForeignKey(d => d.KorisnikId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Komentar_Korisnik");

            entity.HasOne(d => d.Novosti).WithMany(p => p.Komentaris)
                .HasForeignKey(d => d.NovostiId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Komentar_Clanak");
        });

        modelBuilder.Entity<Korisnici>(entity =>
        {
            entity.HasKey(e => e.KorisnikId).HasName("PK__Korisnic__80B06D61682269ED");

            entity.ToTable("Korisnici");

            entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");
            entity.Property(e => e.Email)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.FirstName).HasMaxLength(255);
            entity.Property(e => e.Isverified)
                .HasDefaultValueSql("((0))")
                .HasColumnName("ISVerified");
            entity.Property(e => e.LastName).HasMaxLength(255);
            entity.Property(e => e.PasswordHash)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.PasswordSalt)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.RegisteredOn).HasColumnType("datetime");
            entity.Property(e => e.State)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasDefaultValueSql("('Aktivan')");
            entity.Property(e => e.Username)
                .HasMaxLength(255)
                .IsUnicode(false);
        });

        modelBuilder.Entity<KorisnikUloge>(entity =>
        {
            entity.HasKey(e => e.KorisnikUlogeId).HasName("PK__Korisnik__1D2AF96B4830F74F");

            entity.ToTable("KorisnikUloge");

            entity.Property(e => e.KorisnikUlogeId).HasColumnName("KorisnikUlogeID");
            entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");
            entity.Property(e => e.UlogaId).HasColumnName("UlogaID");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.KorisnikUloges)
                .HasForeignKey(d => d.KorisnikId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__KorisnikU__Koris__29572725");

            entity.HasOne(d => d.Uloga).WithMany(p => p.KorisnikUloges)
                .HasForeignKey(d => d.UlogaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__KorisnikU__Uloga__286302EC");
        });

        modelBuilder.Entity<Novosti>(entity =>
        {
            entity.HasKey(e => e.NovostiId).HasName("PK__Novosti__451A10AB59CD19C7");

            entity.ToTable("Novosti");

            entity.Property(e => e.NovostiId).HasColumnName("NovostiID");
            entity.Property(e => e.DatumObjave)
                .HasDefaultValueSql("('01-01-2024')")
                .HasColumnType("date");
            entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");
            entity.Property(e => e.Naslov)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasDefaultValueSql("('not_defined')");
            entity.Property(e => e.Sadrzaj).HasColumnType("text");
            entity.Property(e => e.Tip)
                .HasMaxLength(255)
                .IsUnicode(false);

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Novostis)
                .HasForeignKey(d => d.KorisnikId)
                .HasConstraintName("FK__Novosti__Korisni__607251E5");
        });

        modelBuilder.Entity<Recenzije>(entity =>
        {
            entity.HasKey(e => e.RecenzijaId).HasName("PK__Recenzij__D36C609035D7347D");

            entity.ToTable("Recenzije");

            entity.Property(e => e.RecenzijaId).HasColumnName("RecenzijaID");
            entity.Property(e => e.Komentar)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");
            entity.Property(e => e.State)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasDefaultValueSql("('Aktivna')");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Recenzijes)
                .HasForeignKey(d => d.KorisnikId)
                .HasConstraintName("FK__Recenzije__Koris__7755B73D");
        });

        modelBuilder.Entity<TestnaVoznja>(entity =>
        {
            entity.HasKey(e => e.TestnaVoznjaId).HasName("PK__TestnaVo__07A84ABB6D4E61DD");

            entity.ToTable("TestnaVoznja");

            entity.Property(e => e.TestnaVoznjaId).HasColumnName("TestnaVoznjaID");
            entity.Property(e => e.AutomobilId).HasColumnName("AutomobilID");
            entity.Property(e => e.DatumVrijeme).HasColumnType("datetime");
            entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");
            entity.Property(e => e.Status)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasDefaultValueSql("('Slobodno')");
            entity.Property(e => e.UposlenikId).HasColumnName("UposlenikID");

            entity.HasOne(d => d.Automobil).WithMany(p => p.TestnaVoznjas)
                .HasForeignKey(d => d.AutomobilId)
                .HasConstraintName("FK_Automobil_TestnaVoznja");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.TestnaVoznjas)
                .HasForeignKey(d => d.KorisnikId)
                .HasConstraintName("FK_Korisnik_TestnaVoznja");

            entity.HasOne(d => d.Uposlenik).WithMany(p => p.TestnaVoznjas)
                .HasForeignKey(d => d.UposlenikId)
                .HasConstraintName("FK_Uposlenik_TestnaVoznja");
        });

        modelBuilder.Entity<Transakcije>(entity =>
        {
            entity.HasKey(e => e.TransakcijaId).HasName("PK__Transakc__BED360B32C9FDA6C");

            entity.ToTable("Transakcije");

            entity.Property(e => e.TransakcijaId).HasColumnName("TransakcijaID");
            entity.Property(e => e.BrojTransakcije)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.DatumTransakcije).HasColumnType("datetime");
            entity.Property(e => e.Iznos)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");
            entity.Property(e => e.TipTransakcije)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Valuta)
                .HasMaxLength(255)
                .IsUnicode(false);

            entity.HasOne(d => d.Korisnik).WithMany(p => p.Transakcijes)
                .HasForeignKey(d => d.KorisnikId)
                .HasConstraintName("FK__Transakci__Koris__0880433F");
        });

        modelBuilder.Entity<Uloge>(entity =>
        {
            entity.HasKey(e => e.UlogaId).HasName("PK__Uloge__DCAB23EB3EE27DDE");

            entity.ToTable("Uloge");

            entity.Property(e => e.UlogaId).HasColumnName("UlogaID");
            entity.Property(e => e.Naziv)
                .HasMaxLength(255)
                .IsUnicode(false);
        });

        modelBuilder.Entity<Uposlenici>(entity =>
        {
            entity.HasKey(e => e.UposlenikId).HasName("PK__Uposleni__B56B4D508CDFFF4F");

            entity.ToTable("Uposlenici");

            entity.Property(e => e.UposlenikId).HasColumnName("UposlenikID");
            entity.Property(e => e.FirstName)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Kontakt)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.LastName)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.State)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasDefaultValueSql("('Aktivan')");
            entity.Property(e => e.Title)
                .HasMaxLength(255)
                .IsUnicode(false);
        });

        modelBuilder.Entity<ZavrseniPoslovi>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Zavrseni__3214EC270EF257BC");

            entity.ToTable("Zavrseni_Poslovi");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.AutomobilId).HasColumnName("AutomobilID");
            entity.Property(e => e.DatumProdaje).HasColumnType("date");
            entity.Property(e => e.Iznos).HasColumnType("decimal(18, 2)");
            entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");

            entity.HasOne(d => d.Automobil).WithMany(p => p.ZavrseniPoslovis)
                .HasForeignKey(d => d.AutomobilId)
                .HasConstraintName("FK_Automobil");

            entity.HasOne(d => d.Korisnik).WithMany(p => p.ZavrseniPoslovis)
                .HasForeignKey(d => d.KorisnikId)
                .HasConstraintName("FK_Korisnik");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
