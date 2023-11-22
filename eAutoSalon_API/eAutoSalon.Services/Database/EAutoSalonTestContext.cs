using System;
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

    public virtual DbSet<Komentari> Komentaris { get; set; }

    public virtual DbSet<Korisnici> Korisnicis { get; set; }

    public virtual DbSet<KorisnikUloge> KorisnikUloges { get; set; }

    public virtual DbSet<Novosti> Novostis { get; set; }

    public virtual DbSet<Uloge> Uloges { get; set; }



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
            entity.Property(e => e.SnagaMotora)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.VrstaGoriva)
                .HasMaxLength(100)
                .IsUnicode(false);
        });

        modelBuilder.Entity<Komentari>(entity =>
        {
            entity.HasKey(e => e.KomentarId).HasName("PK__Komentar__C0C304BC315EAC2A");

            entity.ToTable("Komentari");

            entity.Property(e => e.KomentarId).HasColumnName("KomentarID");
            entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");
            entity.Property(e => e.NovostiId).HasColumnName("NovostiID");
            entity.Property(e => e.Sadrzaj).HasColumnType("text");

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
            entity.Property(e => e.LastName).HasMaxLength(255);
            entity.Property(e => e.PasswordHash)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.PasswordSalt)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.SlikaPath)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("Slika_PATH");
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
            entity.Property(e => e.Sadrzaj).HasColumnType("text");
            entity.Property(e => e.SlikaPath)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("Slika_PATH");
            entity.Property(e => e.Tip)
                .HasMaxLength(255)
                .IsUnicode(false);
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

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
