using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace eAutoSalon.Services.Database;

public partial class EAutoSalonDbContext : DbContext
{
    public EAutoSalonDbContext()
    {
    }

    public EAutoSalonDbContext(DbContextOptions<EAutoSalonDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Korisnici> Korisnicis { get; set; }

    public virtual DbSet<KorisnikUloge> KorisnikUloges { get; set; }

    public virtual DbSet<Uloge> Uloges { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Data Source=localhost;Initial Catalog=eAutoSalon_db; user=sa; Password=TasTatura_123; TrustServerCertificate=True");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Korisnici>(entity =>
        {
            entity.HasKey(e => e.KorisnikId).HasName("PK__Korisnic__80B06D61093A3699");

            entity.ToTable("Korisnici");

            entity.Property(e => e.KorisnikId).HasColumnName("KorisnikID");
            entity.Property(e => e.FirstName)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.LastName)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.PasswordHash)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.PasswordSalt)
                .HasMaxLength(255)
                .IsUnicode(false);
            entity.Property(e => e.Username)
                .HasMaxLength(255)
                .IsUnicode(false);
        });

        modelBuilder.Entity<KorisnikUloge>(entity =>
        {
            entity.HasKey(e => e.KorisnikUlogeId).HasName("PK__Korisnik__1D2AF96B24AC7497");

            entity.ToTable("KorisnikUloge");

            entity.Property(e => e.KorisnikUlogeId).HasColumnName("KorisnikUlogeID");
            entity.Property(e => e.KuKorisnikId).HasColumnName("KU_KorisnikID");
            entity.Property(e => e.KuUlogaId).HasColumnName("KU_UlogaID");

            entity.HasOne(d => d.KuKorisnik).WithMany(p => p.KorisnikUloges)
                .HasForeignKey(d => d.KuKorisnikId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Korisnik_KorisnikUloga");

            entity.HasOne(d => d.KuUloga).WithMany(p => p.KorisnikUloges)
                .HasForeignKey(d => d.KuUlogaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Uloga_KorisnikUloga");
        });

        modelBuilder.Entity<Uloge>(entity =>
        {
            entity.HasKey(e => e.UlogaId).HasName("PK__Uloge__DCAB23EB37F17744");

            entity.ToTable("Uloge");

            entity.Property(e => e.UlogaId).HasColumnName("UlogaID");
            entity.Property(e => e.NazivUloge)
                .HasMaxLength(255)
                .IsUnicode(false);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
