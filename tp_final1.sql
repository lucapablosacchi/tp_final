USE [master]
GO
/****** Object:  Database [tp_final]    Script Date: 28/6/2022 08:56:09 ******/
CREATE DATABASE [tp_final]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'tp_final', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\tp_final.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'tp_final_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\tp_final_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [tp_final] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [tp_final].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [tp_final] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [tp_final] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [tp_final] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [tp_final] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [tp_final] SET ARITHABORT OFF 
GO
ALTER DATABASE [tp_final] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [tp_final] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [tp_final] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [tp_final] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [tp_final] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [tp_final] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [tp_final] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [tp_final] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [tp_final] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [tp_final] SET  DISABLE_BROKER 
GO
ALTER DATABASE [tp_final] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [tp_final] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [tp_final] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [tp_final] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [tp_final] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [tp_final] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [tp_final] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [tp_final] SET RECOVERY FULL 
GO
ALTER DATABASE [tp_final] SET  MULTI_USER 
GO
ALTER DATABASE [tp_final] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [tp_final] SET DB_CHAINING OFF 
GO
ALTER DATABASE [tp_final] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [tp_final] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [tp_final] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'tp_final', N'ON'
GO
ALTER DATABASE [tp_final] SET QUERY_STORE = OFF
GO
USE [tp_final]
GO
/****** Object:  User [alumno]    Script Date: 28/6/2022 08:56:10 ******/
CREATE USER [alumno] FOR LOGIN [alumno] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[PeliculasXPersonajes]    Script Date: 28/6/2022 08:56:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PeliculasXPersonajes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[fk_PëliculasYSeries] [int] NULL,
	[fk_Personajes] [int] NULL,
 CONSTRAINT [PK_PeliculasXPersonajes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[peliculasYSeries]    Script Date: 28/6/2022 08:56:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[peliculasYSeries](
	[idpeliculasYSeries] [int] IDENTITY(1,1) NOT NULL,
	[imagen] [varchar](150) NULL,
	[titulo] [varchar](150) NULL,
	[fechaDeCreacion] [date] NULL,
	[calificacion] [int] NULL,
 CONSTRAINT [PK_peliculasYSeries] PRIMARY KEY CLUSTERED 
(
	[idpeliculasYSeries] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[personajes]    Script Date: 28/6/2022 08:56:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[personajes](
	[idPersonajes] [int] IDENTITY(1,1) NOT NULL,
	[imagen] [varchar](250) NULL,
	[nombre] [varchar](250) NULL,
	[edad] [int] NULL,
	[peso] [float] NULL,
	[historia] [varchar](250) NULL,
 CONSTRAINT [PK_personajes] PRIMARY KEY CLUSTERED 
(
	[idPersonajes] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PeliculasXPersonajes]  WITH CHECK ADD  CONSTRAINT [FK_PeliculasXPersonajes_peliculasYSeries] FOREIGN KEY([fk_PëliculasYSeries])
REFERENCES [dbo].[peliculasYSeries] ([idpeliculasYSeries])
GO
ALTER TABLE [dbo].[PeliculasXPersonajes] CHECK CONSTRAINT [FK_PeliculasXPersonajes_peliculasYSeries]
GO
ALTER TABLE [dbo].[PeliculasXPersonajes]  WITH CHECK ADD  CONSTRAINT [FK_PeliculasXPersonajes_personajes] FOREIGN KEY([fk_Personajes])
REFERENCES [dbo].[personajes] ([idPersonajes])
GO
ALTER TABLE [dbo].[PeliculasXPersonajes] CHECK CONSTRAINT [FK_PeliculasXPersonajes_personajes]
GO
/****** Object:  StoredProcedure [dbo].[sp_insert]    Script Date: 28/6/2022 08:56:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_insert](
@idPelicula int,
@nombrePelicula varchar(100),
@fecha date,
@puntuacion int
)
as
begin
insert into Pelicula values(@nombrePelicula, @fecha, @puntuacion)
end

exec sp_insert @nombrePelicula="El Origen", @fecha="12/2/12", @puntuacion= 8
GO
/****** Object:  StoredProcedure [dbo].[sp_insert1]    Script Date: 28/6/2022 08:56:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_insert1](
@idPelicula int,
@nombrePelicula varchar(100),
@fecha date,
@puntuacion int
)
as
begin
insert into Pelicula values(@nombrePelicula, @fecha, @puntuacion)
end

exec sp_insert1 @nombrePelicula='El Origen', @fecha='12/2/12', @puntuacion='8'
GO
/****** Object:  StoredProcedure [dbo].[sp_insert11]    Script Date: 28/6/2022 08:56:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_insert11](
@idPelicula int,
@nombrePelicula varchar(100),
@fecha date,
@puntuacion int
)
as
begin
insert into Pelicula values(@nombrePelicula, @fecha, @puntuacion)
end

exec sp_insert11 @nombrePelicula=El , @fecha=1, @puntuacion=8
GO
USE [master]
GO
ALTER DATABASE [tp_final] SET  READ_WRITE 
GO
