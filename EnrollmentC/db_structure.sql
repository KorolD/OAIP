USE [master]
GO
/****** Object:  Database [Enrollment_campaign]    Script Date: 26.12.2017 20:19:50 ******/
CREATE DATABASE [Enrollment_campaign]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Entollment_campaign', FILENAME = N'E:\MS_SQL_12\MSSQL11.SQLEXPRESS\MSSQL\DATA\Entollment_campaign.mdf' , SIZE = 5120KB , MAXSIZE = 307200KB , FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Entollment_campaign_log', FILENAME = N'E:\MS_SQL_12\MSSQL11.SQLEXPRESS\MSSQL\DATA\Entollment_campaign_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Enrollment_campaign] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Enrollment_campaign].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Enrollment_campaign] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Enrollment_campaign] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Enrollment_campaign] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Enrollment_campaign] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Enrollment_campaign] SET ARITHABORT OFF 
GO
ALTER DATABASE [Enrollment_campaign] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Enrollment_campaign] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Enrollment_campaign] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Enrollment_campaign] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Enrollment_campaign] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Enrollment_campaign] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Enrollment_campaign] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Enrollment_campaign] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Enrollment_campaign] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Enrollment_campaign] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Enrollment_campaign] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Enrollment_campaign] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Enrollment_campaign] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Enrollment_campaign] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Enrollment_campaign] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Enrollment_campaign] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Enrollment_campaign] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Enrollment_campaign] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Enrollment_campaign] SET  MULTI_USER 
GO
ALTER DATABASE [Enrollment_campaign] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Enrollment_campaign] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Enrollment_campaign] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Enrollment_campaign] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [Enrollment_campaign]
GO
/****** Object:  User [IIS APPPOOL\DefaultAppPool]    Script Date: 26.12.2017 20:19:50 ******/
CREATE USER [IIS APPPOOL\DefaultAppPool] FOR LOGIN [IIS APPPOOL\DefaultAppPool] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_datareader] ADD MEMBER [IIS APPPOOL\DefaultAppPool]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [IIS APPPOOL\DefaultAppPool]
GO
/****** Object:  Table [dbo].[enrollees]    Script Date: 26.12.2017 20:19:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[enrollees](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](20) NOT NULL,
	[surname] [nvarchar](20) NOT NULL,
	[patronymic] [nvarchar](20) NOT NULL,
	[email] [varchar](256) NOT NULL,
	[passport] [nchar](20) NULL,
	[country] [nvarchar](25) NULL,
	[locality] [nvarchar](25) NOT NULL,
	[address] [nvarchar](25) NOT NULL,
	[password] [varchar](255) NOT NULL,
	[birthdate] [date] NOT NULL,
 CONSTRAINT [PK_enrollees_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[exams_enum]    Script Date: 26.12.2017 20:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[exams_enum](
	[ID] [smallint] IDENTITY(1,1) NOT NULL,
	[subject] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_CT_enum] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[exams_results]    Script Date: 26.12.2017 20:19:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[exams_results](
	[enrollee_ID] [int] NOT NULL,
	[exams_enum_ID] [smallint] NOT NULL,
	[result] [smallint] NOT NULL,
 CONSTRAINT [PK_exams_results] PRIMARY KEY CLUSTERED 
(
	[enrollee_ID] ASC,
	[exams_enum_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_enrollees_1]    Script Date: 26.12.2017 20:19:51 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_enrollees_1] ON [dbo].[enrollees]
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[exams_results]  WITH CHECK ADD  CONSTRAINT [FK_exams_results_Enrollees] FOREIGN KEY([enrollee_ID])
REFERENCES [dbo].[enrollees] ([ID])
GO
ALTER TABLE [dbo].[exams_results] CHECK CONSTRAINT [FK_exams_results_Enrollees]
GO
ALTER TABLE [dbo].[exams_results]  WITH CHECK ADD  CONSTRAINT [FK_exams_results_exams_enum] FOREIGN KEY([exams_enum_ID])
REFERENCES [dbo].[exams_enum] ([ID])
GO
ALTER TABLE [dbo].[exams_results] CHECK CONSTRAINT [FK_exams_results_exams_enum]
GO
USE [master]
GO
ALTER DATABASE [Enrollment_campaign] SET  READ_WRITE 
GO
