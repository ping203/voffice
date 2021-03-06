USE [master]
GO
/****** Object:  Database [VOffice]    Script Date: 5/14/2017 9:11:48 AM ******/
CREATE DATABASE [VOffice] ON  PRIMARY 
( NAME = N'DocumentManagerSystem', FILENAME = N'E:\DB\DocumentManagerSystem.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DocumentManagerSystem_log', FILENAME = N'E:\DB\DocumentManagerSystem_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [VOffice].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [VOffice] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [VOffice] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [VOffice] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [VOffice] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [VOffice] SET ARITHABORT OFF 
GO
ALTER DATABASE [VOffice] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [VOffice] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [VOffice] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [VOffice] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [VOffice] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [VOffice] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [VOffice] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [VOffice] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [VOffice] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [VOffice] SET  DISABLE_BROKER 
GO
ALTER DATABASE [VOffice] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [VOffice] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [VOffice] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [VOffice] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [VOffice] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [VOffice] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [VOffice] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [VOffice] SET RECOVERY FULL 
GO
ALTER DATABASE [VOffice] SET  MULTI_USER 
GO
ALTER DATABASE [VOffice] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [VOffice] SET DB_CHAINING OFF 
GO
EXEC sys.sp_db_vardecimal_storage_format N'VOffice', N'ON'
GO
USE [VOffice]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [VOffice]
GO
/****** Object:  User [voffice]    Script Date: 5/14/2017 9:11:48 AM ******/
CREATE USER [voffice] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
sys.sp_addrolemember @rolename = N'db_owner', @membername = N'voffice'
GO
/****** Object:  Schema [cate]    Script Date: 5/14/2017 9:11:48 AM ******/
CREATE SCHEMA [cate]
GO
/****** Object:  Schema [cld]    Script Date: 5/14/2017 9:11:48 AM ******/
CREATE SCHEMA [cld]
GO
/****** Object:  Schema [doc]    Script Date: 5/14/2017 9:11:48 AM ******/
CREATE SCHEMA [doc]
GO
/****** Object:  Schema [organiz]    Script Date: 5/14/2017 9:11:48 AM ******/
CREATE SCHEMA [organiz]
GO
/****** Object:  Schema [share]    Script Date: 5/14/2017 9:11:48 AM ******/
CREATE SCHEMA [share]
GO
/****** Object:  Schema [task]    Script Date: 5/14/2017 9:11:48 AM ******/
CREATE SCHEMA [task]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_Split]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create FUNCTION [dbo].[fn_Split](@text varchar(8000), @delimiter varchar(20) = ' ')
RETURNS @Strings TABLE
(   
  position int IDENTITY PRIMARY KEY,
  value INT 
)
AS
BEGIN
DECLARE @index int
SET @index = -1
WHILE (LEN(@text) > 0)
 BEGIN 
    SET @index = CHARINDEX(@delimiter , @text) 
    IF (@index = 0) AND (LEN(@text) > 0) 
      BEGIN  
        INSERT INTO @Strings VALUES (@text)
          BREAK 
      END 
    IF (@index > 1) 
      BEGIN  
        INSERT INTO @Strings VALUES (LEFT(@text, @index - 1))  
        SET @text = RIGHT(@text, (LEN(@text) - @index)) 
      END 
    ELSE
      SET @text = RIGHT(@text, (LEN(@text) - @index))
    END
  RETURN
END

GO
/****** Object:  Table [cate].[Country]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cate].[Country](
	[Id] [int] NOT NULL,
	[Title] [nvarchar](256) NOT NULL,
	[TwoLettersCode] [nvarchar](2) NULL,
	[ThreeLettersCode] [nvarchar](3) NULL,
	[NumberCode] [int] NULL,
	[Order] [int] NOT NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [cate].[Customer]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cate].[Customer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Title] [nvarchar](1000) NOT NULL,
	[ShortTitle] [nvarchar](256) NULL,
	[Order] [int] NOT NULL,
	[Address] [nvarchar](1000) NULL,
	[PhoneNumber] [nvarchar](50) NULL,
	[Fax] [nvarchar](50) NULL,
	[TaxNumber] [nvarchar](50) NULL,
	[BankName] [nvarchar](1000) NULL,
	[BankAccountNumber] [nvarchar](256) NULL,
	[Active] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[EditedOn] [datetime] NOT NULL,
	[EditedBy] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [cate].[MeetingRoom]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cate].[MeetingRoom](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Title] [nvarchar](256) NOT NULL,
	[Description] [nvarchar](1000) NULL,
	[Address] [nvarchar](1000) NULL,
	[Capacity] [int] NULL,
	[Splittable] [bit] NOT NULL,
	[Shareable] [bit] NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[Order] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[EditedOn] [datetime] NOT NULL,
	[EditedBy] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_MeetingRoom] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [cate].[Status]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cate].[Status](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Title] [nvarchar](256) NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
	[Active] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[EditedOn] [datetime] NOT NULL,
	[EditedBy] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [cld].[Event]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cld].[Event](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[OccurDate] [datetime] NOT NULL,
	[Content] [nvarchar](1000) NULL,
	[Place] [nvarchar](500) NULL,
	[MeetingRoomId] [int] NULL,
	[Participant] [nvarchar](1000) NULL,
	[StartTime] [datetime] NULL,
	[StartTimeUnderfined] [datetime] NOT NULL,
	[EndTime] [datetime] NULL,
	[EndTimeUndefined] [bit] NOT NULL,
	[Morning] [bit] NOT NULL,
	[Public] [bit] NOT NULL,
	[Important] [bit] NOT NULL,
	[NotificationTimeSpan] [int] NULL,
	[LeaderId] [int] NULL,
	[Accepted] [bit] NOT NULL,
	[AcceptedBy] [nvarchar](128) NULL,
	[AcceptedOn] [datetime] NULL,
	[Canceled] [bit] NOT NULL,
	[CanceledBy] [nvarchar](128) NULL,
	[CanceledOn] [datetime] NULL,
	[Active] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[EditedOn] [datetime] NOT NULL,
	[EditedBy] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_Event] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [cld].[EventUserNotify]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cld].[EventUserNotify](
	[EventId] [int] NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_EventUser] PRIMARY KEY CLUSTERED 
(
	[EventId] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [cld].[ImportantJob]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cld].[ImportantJob](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[Note] [bit] NOT NULL,
	[Content] [nvarchar](1000) NULL,
	[Active] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[EditedOn] [datetime] NOT NULL,
	[EditedBy] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_ImportantJob] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetGroupRoles]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetGroupRoles](
	[GroupId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_AspNetGroupRoles] PRIMARY KEY CLUSTERED 
(
	[GroupId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetGroups]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetGroups](
	[Id] [nvarchar](128) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[Active] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[EditedOn] [datetime] NOT NULL,
	[EditedBy] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_AspNetGroups] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetGroupUsers]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetGroupUsers](
	[GroupId] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_AspNetGroupUsers] PRIMARY KEY CLUSTERED 
(
	[GroupId] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[GroupBy] [nvarchar](256) NOT NULL,
	[Order] [int] NOT NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
	[Grant] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
	[GoogleAccount] [nvarchar](256) NULL,
	[ExpiryDate] [datetime] NULL,
	[Deleted] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[EditedOn] [datetime] NOT NULL,
	[EditedBy] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [doc].[DocumentAttachment]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [doc].[DocumentAttachment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FileName] [nvarchar](256) NOT NULL,
	[FilePath] [nvarchar](1000) NOT NULL,
	[DocumentId] [int] NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[ReceivedDocument] [bit] NOT NULL,
	[Active] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[EditedOn] [datetime] NOT NULL,
	[EditedBy] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_DocumentAttachment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [doc].[DocumentDelivered]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [doc].[DocumentDelivered](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DocumentNumber] [nvarchar](256) NULL,
	[Title] [nvarchar](500) NOT NULL,
	[DocumentDate] [smalldatetime] NOT NULL,
	[DeliveredDate] [smalldatetime] NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[ExternalReceiveDivisionId] [int] NULL,
	[ExternalReceiveDivision] [nvarchar](1000) NULL,
	[RecipientsDivision] [nvarchar](1000) NULL,
	[SignedById] [int] NULL,
	[SignedBy] [nvarchar](256) NULL,
	[DocumentTypeId] [int] NOT NULL,
	[NumberOfCopies] [int] NOT NULL,
	[NumberOfPages] [int] NOT NULL,
	[SecretLevel] [tinyint] NOT NULL,
	[UrgencyLevel] [tinyint] NOT NULL,
	[Note] [nvarchar](1000) NULL,
	[OriginalSavingPlace] [nvarchar](1000) NULL,
	[LegalDocument] [bit] NOT NULL,
	[AttachmentName] [nvarchar](256) NOT NULL,
	[AttachmentPath] [nvarchar](1000) NOT NULL,
	[Active] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[EditedOn] [datetime] NOT NULL,
	[EditedBy] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_DeliveredDocument] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [doc].[DocumentDocumentFields]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [doc].[DocumentDocumentFields](
	[DocumentId] [int] NOT NULL,
	[DocumentFieldDepartmentId] [int] NOT NULL,
	[ReceivedDocument] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_DocumentDocumentFields] PRIMARY KEY CLUSTERED 
(
	[DocumentId] ASC,
	[DocumentFieldDepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [doc].[DocumentField]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [doc].[DocumentField](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Title] [nvarchar](256) NOT NULL,
	[AllowClientEdit] [bit] NOT NULL,
	[Active] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[EditedOn] [datetime] NOT NULL,
	[EditedBy] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_Doc_Field] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [doc].[DocumentFieldDepartment]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [doc].[DocumentFieldDepartment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FieldId] [int] NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Title] [nvarchar](256) NOT NULL,
	[Active] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[EditedOn] [datetime] NOT NULL,
	[EditedBy] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_DocumentFieldDepartment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [doc].[DocumentHistory]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [doc].[DocumentHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DocumentId] [int] NOT NULL,
	[ReceivedDocument] [bit] NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[AttempOn] [datetime] NOT NULL,
 CONSTRAINT [PK_DocumentHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [doc].[DocumentOpinion]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [doc].[DocumentOpinion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Content] [nvarchar](1000) NOT NULL,
	[DocumentId] [int] NULL,
	[ReceivedDocument] [bit] NOT NULL,
	[LeaderId] [int] NULL,
	[Active] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[EditedOn] [datetime] NOT NULL,
	[EditedBy] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_Opinion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [doc].[DocumentOpinionAttachment]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [doc].[DocumentOpinionAttachment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FileName] [nvarchar](256) NOT NULL,
	[FilePath] [nvarchar](1000) NOT NULL,
	[OpinionId] [int] NOT NULL,
	[Type] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[EditedOn] [datetime] NOT NULL,
	[EditedBy] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_DocumentOpinionAttachment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [doc].[DocumentReceived]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [doc].[DocumentReceived](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DocumentNumber] [nvarchar](50) NULL,
	[ReceivedNumber] [nvarchar](50) NULL,
	[Title] [nvarchar](500) NOT NULL,
	[DocumentDate] [smalldatetime] NOT NULL,
	[ReceivedDate] [smalldatetime] NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[ExternalFromDivisionId] [int] NULL,
	[ExternalFromDivision] [nvarchar](1000) NULL,
	[RecipientsDivision] [nvarchar](4000) NULL,
	[SignedById] [int] NULL,
	[SignedBy] [nvarchar](256) NULL,
	[DocumentTypeId] [int] NOT NULL,
	[AddedDocumentBook] [bit] NOT NULL,
	[DocumentBookAddedOn] [datetime] NULL,
	[DocumentBookAddedBy] [nvarchar](128) NULL,
	[NumberOfCopies] [int] NOT NULL,
	[NumberOfPages] [int] NOT NULL,
	[SecretLevel] [tinyint] NOT NULL,
	[UrgencyLevel] [tinyint] NOT NULL,
	[Note] [nvarchar](500) NULL,
	[OriginalSavingPlace] [nvarchar](256) NULL,
	[LegalDocument] [bit] NOT NULL,
	[AttachmentName] [nvarchar](256) NOT NULL,
	[AttachmentPath] [nvarchar](1000) NOT NULL,
	[DeliveredDocumentId] [int] NULL,
	[ReceivedDocumentId] [int] NULL,
	[Active] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[EditedOn] [datetime] NOT NULL,
	[EditedBy] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_ReceivedDocument] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [doc].[DocumentRecipent]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [doc].[DocumentRecipent](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DocumentId] [int] NOT NULL,
	[UserId] [nvarchar](128) NULL,
	[DepartmentId] [int] NULL,
	[ReceivedDocument] [bit] NOT NULL,
	[Forwarded] [bit] NOT NULL,
	[Assigned] [bit] NOT NULL,
	[AddedDocumentBook] [bit] NOT NULL,
	[ForSending] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_DocumentRecipent] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [doc].[DocumentSignedBy]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [doc].[DocumentSignedBy](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](256) NOT NULL,
	[Position] [nvarchar](500) NULL,
	[DepartmentId] [int] NULL,
	[ReceivedDocument] [bit] NOT NULL,
	[Active] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[EditedOn] [datetime] NOT NULL,
	[EditedBy] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_DocumentSigned] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [doc].[DocumentType]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [doc].[DocumentType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Title] [nvarchar](256) NOT NULL,
	[Active] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[EditedOn] [datetime] NOT NULL,
	[EditedBy] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_Doc_Type] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [doc].[ExternalSendReceiveDivision]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [doc].[ExternalSendReceiveDivision](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](1000) NOT NULL,
	[ReceivedDocument] [bit] NOT NULL,
	[Active] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[EditedOn] [datetime] NOT NULL,
	[EditedBy] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_ExternalRecipent] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [organiz].[Department]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [organiz].[Department](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](1000) NOT NULL,
	[ShortName] [nvarchar](256) NULL,
	[Root] [bit] NOT NULL,
	[ParentId] [int] NOT NULL,
	[Order] [int] NOT NULL,
	[Address] [nvarchar](1000) NULL,
	[PhoneNumber] [nvarchar](50) NULL,
	[Fax] [nvarchar](50) NULL,
	[TaxNumber] [nvarchar](50) NULL,
	[BankName] [nvarchar](1000) NULL,
	[BankAccountNumber] [nvarchar](256) NULL,
	[Active] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[EditedOn] [datetime] NOT NULL,
	[EditedBy] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [organiz].[DepartmentStaffs]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [organiz].[DepartmentStaffs](
	[DepartmentId] [int] NOT NULL,
	[StaffId] [int] NOT NULL,
	[Position] [nvarchar](500) NULL,
	[MainDepartment] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[EditedOn] [datetime] NOT NULL,
	[EditedBy] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_DepartmentStaffs] PRIMARY KEY CLUSTERED 
(
	[DepartmentId] ASC,
	[StaffId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [organiz].[Staff]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [organiz].[Staff](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StaffCode] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[FullName] [nvarchar](256) NOT NULL,
	[UserId] [nvarchar](128) NULL,
	[Email] [nvarchar](256) NOT NULL,
	[PhoneNumber] [nvarchar](50) NOT NULL,
	[DateOfBirth] [datetime] NULL,
	[Gender] [int] NULL,
	[Address] [nvarchar](500) NULL,
	[Avatar] [nvarchar](500) NULL,
	[Order] [int] NOT NULL,
	[Leader] [bit] NOT NULL,
	[SeniorLeader] [bit] NOT NULL,
	[SignedBy] [bit] NOT NULL,
	[Active] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[EditedOn] [datetime] NOT NULL,
	[EditedBy] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_Staff] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [share].[ApplicationLogging]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [share].[ApplicationLogging](
	[Id] [int] NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
	[ModelName] [nvarchar](256) NULL,
	[ModelId] [int] NULL,
	[ModelProperty] [nvarchar](256) NULL,
	[OldValue] [nvarchar](max) NULL,
	[NewValue] [nvarchar](max) NULL,
	[Message] [nvarchar](max) NULL,
	[UserHostAddress] [nvarchar](256) NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_share.ApplicationLoging] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [share].[Function]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [share].[Function](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Title] [nvarchar](256) NOT NULL,
	[ParentId] [int] NOT NULL,
	[Href] [nvarchar](500) NULL,
	[Target] [nvarchar](10) NOT NULL,
	[Icon] [nvarchar](256) NULL,
	[Order] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[EditedOn] [datetime] NOT NULL,
	[EditedBy] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_Function] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [share].[RoleFunction]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [share].[RoleFunction](
	[RoleId] [nvarchar](128) NOT NULL,
	[FunctionId] [int] NOT NULL,
 CONSTRAINT [PK_RoleFunction] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC,
	[FunctionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [share].[SystemConfig]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [share].[SystemConfig](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](256) NOT NULL,
	[Value] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[Type] [int] NOT NULL,
	[AllowClientEdit] [bit] NOT NULL,
	[Active] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[EditedOn] [datetime] NOT NULL,
	[EditedBy] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_SystemConfig] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [share].[SystemConfigDepartment]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [share].[SystemConfigDepartment](
	[DepartmentId] [int] NOT NULL,
	[ConfigId] [int] NOT NULL,
	[Value] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[EditedOn] [datetime] NOT NULL,
	[EditedBy] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_SystemConfigDepartment] PRIMARY KEY CLUSTERED 
(
	[DepartmentId] ASC,
	[ConfigId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [task].[Project]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [task].[Project](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](500) NOT NULL,
	[ManagerId] [int] NULL,
	[Active] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[EditedOn] [datetime] NOT NULL,
	[EditedBy] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_Project] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [task].[Task]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [task].[Task](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Title] [nvarchar](500) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[DepartmentId] [int] NOT NULL,
	[ProjectId] [int] NULL,
	[TaskTypeId] [int] NULL,
	[StatusId] [int] NOT NULL,
	[Order] [int] NOT NULL,
	[Priority] [int] NOT NULL,
	[DueDate] [datetime] NOT NULL,
	[StartDate] [datetime] NULL,
	[Estimated] [int] NULL,
	[TimeSpent] [int] NULL,
	[EndDate] [datetime] NULL,
	[CustomerId] [int] NOT NULL,
	[ContactInformation] [nvarchar](500) NULL,
	[Rating] [int] NOT NULL,
	[Result] [nvarchar](500) NULL,
	[Active] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[EditedOn] [datetime] NOT NULL,
	[EditedBy] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_Task] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [task].[TaskAssignee]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [task].[TaskAssignee](
	[TaskId] [int] NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[Assignee] [bit] NOT NULL,
	[Coprocessor] [bit] NOT NULL,
	[Supervisor] [bit] NOT NULL,
	[Order] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_TaskAssignee] PRIMARY KEY CLUSTERED 
(
	[TaskId] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [task].[TaskAttachment]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [task].[TaskAttachment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FileName] [nvarchar](256) NOT NULL,
	[FilePath] [nvarchar](1000) NOT NULL,
	[RecordId] [int] NOT NULL,
	[Type] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[EditedOn] [datetime] NOT NULL,
	[EditedBy] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_DocumentAttachment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [task].[TaskDocuments]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [task].[TaskDocuments](
	[TaskId] [int] NOT NULL,
	[DocumentId] [int] NOT NULL,
	[ReceivedDocument] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_TaskDocuments] PRIMARY KEY CLUSTERED 
(
	[TaskId] ASC,
	[DocumentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [task].[TaskOpinion]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [task].[TaskOpinion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Content] [nvarchar](1000) NOT NULL,
	[TaskId] [int] NULL,
	[Active] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[EditedOn] [datetime] NOT NULL,
	[EditedBy] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_TaskOpinion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [task].[TaskType]    Script Date: 5/14/2017 9:11:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [task].[TaskType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Title] [nvarchar](256) NOT NULL,
	[Active] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [nvarchar](128) NOT NULL,
	[EditedOn] [datetime] NOT NULL,
	[EditedBy] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_TaskType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[__MigrationHistory] ([MigrationId], [ContextKey], [Model], [ProductVersion]) VALUES (N'201702070210157_InitialCreate', N'CreateUserDatabase.Models.ApplicationDbContext', 0x1F8B0800000000000400DD5CDB6EDC36107D2FD07F10F4D416CECA9726488DDD04CEDA6E8DC617649DA06F0157E2AE8548942A518E8DA25FD6877E527FA14389BAF1A2CBAEBCBB0E020416393C331C0EC9E170B8FFFDF3EFF8ED83EF19F7388ADD804CCC83D1BE696062078E4B961333A18B17AFCDB76FBEFF6E7CE6F80FC6A79CEE88D1414B124FCC3B4AC363CB8AED3BECA378E4BB7614C4C1828EECC0B790135887FBFBBF58070716060813B00C63FC2121D4F571FA019FD380D838A409F22E03077B312F879A598A6A5C211FC721B2F1C49C461851FC31C6D129A2688E623CCA1A99C689E722106886BD85692042028A28887B0CC4331A0564390BA10079B78F2106BA05F262CCBB715C9277EDD1FE21EB915536CCA1EC24A681DF13F0E088ABC8129BAFA468B3502128F10C944D1F59AF53454ECC0B07A7451F020F1420323C9E7A11239E9897058B9338BCC27494371C6590E711C07D0DA22FA32AE29ED1B9DD5E615287A37DF66FCF98261E4D223C2138A111F2F68C9B64EEB9F6EFF8F136F882C9E4E860BE387AFDF215728E5EFD8C8F5E567B0A7D05BA5A0114DD44418823900D2F8AFE9B86556F67890D8B6695369956C096607698C6257A788FC992DEC1BC397C6D1AE7EE0376F2126E5C1F890B93091AD12881CFABC4F3D0DCC345BDD5C893FDDFC0F5F0E5AB41B85EA17B77990EBDC09FCD3298571FB097D6C6776E984DAFDA787FE664E751E0B3EFBA7D65B59F674112D9AC338196E416454B4CEBD28DADD2783B9934831ADEAC73D4DD376D26A96CDE4A52D6A1556642CE62D3B32197F769F976B6B8933084C14B4D8B69A4C9E0B47BD64800011B91484B433AE86A48043AF82DAF8B673E72BD0116C60E5CC03559B8918F8B5EBE0BC00C11E92DF30D8A6358179CDF507CD7203AFC3980E8336C271198EB8C223F7C726E377701C157893F67B36073BC061B9ADBAFC139B269109D11D66A6DBCF781FD2548E819714ED95CA6760EC83E6F5DBF3BC020E29CD8368EE3733066EC4C03F0BC73C00B428F0E7BC3B1B569DB8EC9D443AEAFF64C8415F5734E5A7A276A0AC943D190A9BC942651DF074B9774133527D58B9A51B48ACAC9FA8ACAC0BA49CA29F582A604AD72665483F97DE9080DEFF8A5B0BBEFF9ADB779EBD6828A1A67B042E25F31C1112C63CE0DA21447A41C812EEBC6369C8574F818D327DF9B524E9F90970CCD6AA5D9902E02C3CF861476F767432A2614DFBB0EF34A3A1C87726280EF44AF3E69B5CF3941B24D4F875A3737CD7C336B806EBA9CC47160BBE92C5004C27818A32E3FF870467B4C23EB8D1817818E81A1BB6CCB8312E89B291AD53539C51EA6D838B1B340E114C53672643542879C1E82E53BAA42B0323E5217EE278927583A8E5823C40E4131CC549750795AB8C47643E4B56A4968D9710B637D2F788835A738C484316CD54417E6EA700813A0E0230C4A9B86C656C5E29A0D51E3B5EAC6BCCD852DC75D8A526CC4265B7C678D5D72FFED490CB359631B30CE66957411401BDADB8681F2B34A5703100F2EBB66A0C2894963A0DCA5DA8881D635B60503ADABE4D919687644ED3AFEC27975D7CCB37E50DEFCB6DEA8AE2DD8664D1F3B669A99EF096D28B4C0916C9EA77356891FA8E2700672F2F359CC5D5DD14418F80CD37AC8A6F477957EA8D50C221A51136069682DA0FC5250029226540FE1F2585EA374DC8BE8019BC7DD1A61F9DA2FC0566C40C6AE5E8E5608F557A8A271763A7D143D2BAC4132F24E87850A8EC220C4C5ABDEF10E4AD1C56565C574F185FB78C3958EF1C16850508BE7AA5152DE99C1B5949B66BB96540E591F976C2D2D09EE93464B796706D712B7D17625299C821E6EC15A2AAA6FE1034DB63CD251EC3645DDD8CA52A778C1D8D2E4588D2F5118BA6459C9B9E225C68C275CBD98F54F41F2330CCB8E15994885B405271A446889855A600D929EBB514CF3BB70D3983ABE44A6DC5B35CB7FCEB2BA7DCA8398EF033935FB9BC778B557F9B52D57F64938D43974D4678E4D1A4D579881BAB9C152E190872245007F1A78894FF47E96BE75768D576D9F95C808634B905FF2A324A549DE6E7D043A8D8F3C37861DABC29B597DBCF4103AADE7BE6855EF3AFF548F9287ABAA28BA10D6D6C64FE7D6AC3266A2E3D87FC85A119E6696F16C952A002FEA8951497890C02A75DD51EB392955CC7A4D774421F1A40A2954F590B29A5E5213B25AB1129E46A36A8AEE1CE484922ABA5CDB1D59915A52855654AF80AD9059ACEB8EAAC83EA9022BAABB6397A928E25ABAC3FB98F638B3EE46961D7CD7DBC934184FB3300EB31156EEF7AB4095E29E58FC065F02E3E53B6954DAD3DFBA4695853DD6332A0D867E1DAA5D90D797A1C65B7D3D66EDD6BBB6D437DDFAEBF1FA99EE931A88740614490AEEC5595038F38DF9F9ABC3E31BF14096919846AE46D8E61F638AFD112318CDFEF4A69E8BD9A29E135C22E22E704CB34C0FF370FFE05078B8B33B8F68AC38763CC5F955F792A63E661B48DA22F728B2EF5024A750ACF1D0A40495A2D317C4C10F13F3AFB4D5711AE8607FA5C57BC645FC91B87F2650711B25D8F85B4E091D26F1BEF9E4B5A3CF24BA6BF5E28FCF59D33DE33A8219736CEC0BBA5C6584EB8F277A4993355D439A959F543CDF09557BA1A0441526C4EA0F12E62E1DE431422EE50F3E7AF8B1AF68CA07076B212A1E150C8537880A758F0656C1D23E1870E093A60F06FA7556FD806015D1B48F075CD21F4C7C3AD07D19CA5B6E71AB511C8D36B124A57A6E4DBD5E2B0F73DB7B9394A1BDD64497B3B07BC0AD9169BD82653CB324E5C17647450EF260D8DB34ED274F3CDE955CE3320B64BB29C69BCC2A6EB82BFAA692897720FD4D91CEB3FD94E14DDB9A2E9CBBE37997FD128377CCD87892D7F6D37F376D6CBA30EF8E1B5BAF24DF1DB3B56DED9F5BB6B4CE5BE8D65376E5EC23CDB58C2A16DC96929B05CEE1843F0FC008328F327B49A9CE016BCA5F6D615892E899EA93CF44C6D2C491F84A14CD6CFBF5956FF88D9DE534CD6C35299B4DBCF9FADFC89BD334F3D624426E239958998AA84AF06E59C79A32A39E53F270AD272DB9EA6D3E6BE31DFB73CA151E4429B5D9A3B9237E3EA9C183A864C8A9D3231558BEEE85BDB3F28B8CB07FC7EEB28460BFCF48B05DDB350B9A0BB208F2CD5B90282711223497982207B6D49388BA0B6453A86631E6F429781AB763371D73EC5C90EB848609852E637FEED5025ECC0968E29FE63BD7651E5F87E9AF9A0CD10510D365B1F96BF22E713DA790FB5C1113D24030EF824774D9585216D95D3E16485701E908C4D5573845B7D80F3D008BAFC90CDDE3556403F37B8F97C87E2C23803A90F681A8AB7D7CEAA26584FC986394EDE1136CD8F11FDEFC0F2301378F98540000, N'6.1.3-40302')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [GoogleAccount], [ExpiryDate], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (N'01332073-b4c7-4706-8786-77a8e985a5da', N'ltab74@yahoo.com', 0, N'AGs7XG/NaX1+DWzvb5mqYNfOLptUV3wDKACOvSOdodj5eoTwuLTgvoN9gbNMwFnnuA==', N'e19ccd8a-02c8-4ac1-9f1f-6ed56a414183', NULL, 0, 0, NULL, 1, 0, N'ltab74@yahoo.com', NULL, NULL, 0, CAST(N'2017-05-11T09:24:17.200' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T09:24:17.200' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [GoogleAccount], [ExpiryDate], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (N'0953e60e-8693-4770-9593-230ec02e2f71', N'phuonghong966@yahoo.com', 0, N'ADj3J9s7Q0h686uDZRg9tbesO4WJnC2tXoHQ8y4lJzQQTpM95EyfcU2L5KtqWMFP8w==', N'b30b4c5d-02e2-433a-a771-2a677e23c1fe', NULL, 0, 0, NULL, 1, 0, N'phuonghong966@yahoo.com', NULL, NULL, 0, CAST(N'2017-05-11T09:30:53.727' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T09:30:53.727' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [GoogleAccount], [ExpiryDate], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (N'24d69d71-7da6-4990-882d-eb21e0e87e69', N'hoangngochai2014@yahoo.com.vn', 0, N'ADcZXsmRxGdVw6G20e8goBcTmlzfU+A5LFCNt1uDGQp9p+F7vaK24POav+3WcEQs6A==', N'5b5d562f-c46c-4419-924b-52821ce0b47c', NULL, 0, 0, NULL, 1, 0, N'hoangngochai2014@yahoo.com.vn', NULL, NULL, 0, CAST(N'2017-05-11T09:34:19.977' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T09:34:19.977' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [GoogleAccount], [ExpiryDate], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (N'2a715a44-3fa9-4a37-8002-8d81b8c44369', N'luyen.dh1985@gmail.com', 0, N'AM7m2Bw5pOVo5ba1kCO0F/ueN0ESE+/rhrT2n22XFPZNP9SSCn6IdZMio+n9x2P+qA==', N'c36161bd-f116-42ec-aedd-482d67d1eb8a', NULL, 0, 0, NULL, 1, 0, N'luyen.dh1985@gmail.com', NULL, NULL, 0, CAST(N'2017-05-11T09:34:37.390' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T09:34:37.390' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [GoogleAccount], [ExpiryDate], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (N'2e9080b7-1154-4df0-8cad-9996d7f752cf', N'tthuy27hn@yahoo.com', 0, N'AAa+pZM7rZZb7mPfRlj0F9aYGKWgEoPZaM+hxcieqVzw34kOlenNk7aY/+lvfW4QSQ==', N'd592c636-0375-441c-9f26-0143a2f02715', NULL, 0, 0, NULL, 1, 0, N'tthuy27hn@yahoo.com', NULL, NULL, 0, CAST(N'2017-05-11T09:29:01.017' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T09:29:01.017' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [GoogleAccount], [ExpiryDate], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (N'32159cb8-a740-4658-978f-36ea6502616d', N'truongphh@gmail.com', 0, N'AEibknlQ+g9T5Ia6lFJ5nEmxI6zw0IBlL2wsLvtoYnZb0TWHcF0RbdgKPTPkHqlPUQ==', N'214a226e-7869-490b-baf7-a790aa7c66f6', NULL, 0, 0, NULL, 1, 0, N'truongphh@gmail.com', NULL, NULL, 0, CAST(N'2017-05-11T09:46:09.857' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T09:46:09.857' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [GoogleAccount], [ExpiryDate], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (N'3d335020-8fcb-4fdd-832a-a44715990904', N'ndthai@moet.gov.vn', 0, N'AIGGEDxXViUjt9RHFsD36iqjVcOtNi6gzCVF4iFaKMntGkGPCxvpBVCn2WgPbZPEjA==', N'09272576-f74e-4578-a8f4-f02b9b926b7d', NULL, 0, 0, NULL, 1, 0, N'ndthai@moet.gov.vn', NULL, NULL, 0, CAST(N'2017-05-11T09:23:14.973' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T09:23:14.973' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [GoogleAccount], [ExpiryDate], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (N'405cd854-ff05-4fa4-8594-ecc7dbade04b', N'thanhhai_hmc@yahoo.com', 0, N'ALMzTpNjD909duw/LfwFMMiaN9ZrNjzaoYBRHGgAqNjyf4h3T4noJee3Ius3hP0nQg==', N'4136c981-22d0-4d62-a990-5a2252ce8a24', NULL, 0, 0, NULL, 1, 0, N'thanhhai_hmc@yahoo.com', NULL, NULL, 0, CAST(N'2017-05-11T09:37:46.960' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T09:37:46.960' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [GoogleAccount], [ExpiryDate], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (N'41b5cdc8-7310-47c6-aa9c-d9afdc4a7728', N'anhpt@vla.vn', 0, N'AGARJ8rpkiBS/fX3SIdqkOcuqvvNSaU2ghLKHi2D5qB3oB3r5Z3Kpf+cFX1JmeugGA==', N'b1eed07d-d73e-401c-9780-65f48d7da3e3', NULL, 0, 0, NULL, 1, 0, N'anhpt@vla.vn', NULL, NULL, 0, CAST(N'2017-05-11T09:36:04.997' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T09:36:04.997' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [GoogleAccount], [ExpiryDate], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (N'4b376c0e-b096-4df7-b55e-fa6e0ab2ea7c', N'tcns_nxbgd@yahoo.com', 0, N'APJsVJ9x3DtkSYVLVuxTXNLi7rXpjH/Z/Sc+MOsgvOdf6HIqd6Z3is+y1hqapta6xw==', N'0e7f9cca-df78-4e71-bc97-627f8111d9d7', NULL, 0, 0, NULL, 1, 0, N'tcns_nxbgd@yahoo.com', NULL, NULL, 0, CAST(N'2017-05-11T09:23:55.317' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T09:23:55.317' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [GoogleAccount], [ExpiryDate], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (N'4ba93710-d0ef-4d0c-a7a1-ca5d7a279e4c', N'hoanghonghanh21@yahoo.com', 0, N'AOr+FEX8iR9O0qfh3zjMjns9PU2g7Ops7REHOFf6BBU5/mX5QWFKh2IrFVsETPelwQ==', N'bc21a0bd-37a9-420a-a6fa-f1d0a769e81a', NULL, 0, 0, NULL, 1, 0, N'hoanghonghanh21@yahoo.com', NULL, NULL, 0, CAST(N'2017-05-11T09:32:10.280' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T09:32:10.280' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [GoogleAccount], [ExpiryDate], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (N'4d1c712b-2dd8-4e1a-b450-6cf0eb0f3a66', N'anhltv@efi.vn', 0, N'AAP+YTI+BZnT2uuWgBxd4IgEtQtxWFPwO5L3E0I1Jj3APcPj4YIRyI+WoEhMrJVGOQ==', N'b5234527-6c2c-4db7-b4fe-50796de0db80', NULL, 0, 0, NULL, 1, 0, N'anhltv@efi.vn', NULL, NULL, 0, CAST(N'2017-05-11T09:31:20.340' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T09:31:20.340' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [GoogleAccount], [ExpiryDate], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (N'4fef25f0-5226-435a-be12-4315e935f5fb', N'honganh150791@gmail.com', 0, N'AMgFw/vqfc2r87YexD4hBN0vGTdfYq+jChgMGLzYjbNOc4F39oNd7FJxeVIraLJPtw==', N'5fc5a076-b7db-4062-b2ff-accdeebd2664', NULL, 0, 0, NULL, 1, 0, N'honganh150791@gmail.com', NULL, NULL, 0, CAST(N'2017-05-11T09:20:44.333' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T09:20:44.333' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [GoogleAccount], [ExpiryDate], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (N'5220b23e-b735-4dcd-99be-80142dbad257', N'tranthuhien183@yahoo.com', 0, N'AEaqbrQIxgqT+AQUODmGPMR63TwX6zA6H/QbmrGcBS5KuZfmTyXhEEH4CZflVSXUCQ==', N'eefafda2-2428-4d55-a5cf-a4b05d7010a0', NULL, 0, 0, NULL, 1, 0, N'tranthuhien183@yahoo.com', NULL, NULL, 0, CAST(N'2017-05-11T09:26:29.420' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T09:26:29.420' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [GoogleAccount], [ExpiryDate], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (N'57fa2008-e2bd-41a0-b0ed-c1293c873c94', N'hoangxuanhoa36@yahoo.com', 0, N'AAzA/zHub943CWC8LeSGb+D4CRe1sKnaLkeaq4qopKBLnK5/Sa5mql6pHY4U0s/ynA==', N'5ab4498b-a4bb-4867-9fac-5ed2fd9d946e', NULL, 0, 0, NULL, 1, 0, N'hoangxuanhoa36@yahoo.com', NULL, NULL, 0, CAST(N'2017-05-11T09:35:09.163' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T09:35:09.163' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [GoogleAccount], [ExpiryDate], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (N'622884a3-1a38-47ce-a199-984adb16adc2', N'hasychuan@yahoo.com', 0, N'AARUpAyt3JWHkIySZUAqEO4cuYLjZomcOZgh9v7VsZY3M5zNm6QhFotDo5XFwAqj1w==', N'e15ba38b-4b10-4367-9749-a05dca60c023', NULL, 0, 0, NULL, 1, 0, N'hasychuan@yahoo.com', NULL, NULL, 0, CAST(N'2017-05-11T09:50:51.630' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T09:50:51.630' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [GoogleAccount], [ExpiryDate], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (N'650578b2-3c12-4b37-b64a-beeef20be60c', N'lananhnxbgd@gmail.com', 0, N'ADNRsdRyEJHttY1ZULALckTajUIRQeHTbEuuLmfhcAoeYfoXsjIZqdPQaxeCvfptKw==', N'c309861e-bf43-4163-b86d-cd2d949bd2c4', NULL, 0, 0, NULL, 1, 0, N'lananhnxbgd@gmail.com', NULL, NULL, 0, CAST(N'2017-05-11T09:25:38.367' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T09:25:38.367' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [GoogleAccount], [ExpiryDate], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (N'69fb3b53-994f-4d4c-b951-6b6406945178', N'vudangquangtrung@yahoo.com', 0, N'ALY9efCJLBCHdhqu5vfTx+xLCFtB2wGiwpy4+zpEpitiSj/yAl2XgsbbzrPAX4CjOw==', N'6292cc9a-e9f0-479f-8018-19a947e9fead', NULL, 0, 0, NULL, 1, 0, N'vudangquangtrung@yahoo.com', NULL, NULL, 0, CAST(N'2017-05-11T09:28:38.077' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T09:28:38.077' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [GoogleAccount], [ExpiryDate], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (N'757f04c2-7928-44cb-92c6-39c05ccd242b', N'lehoaithanh@gmail.com', 0, N'ANDHMxov0T/Bo2ahyOcMZvsFzlz0efWi3iwPgk5DH+q4RU2WA1BC9PhwJj7T6KcHRA==', N'd798a1e5-89a1-49be-8977-d09dfe8933bd', NULL, 0, 0, NULL, 1, 0, N'lehoaithanh@gmail.com', NULL, NULL, 0, CAST(N'2017-05-11T09:19:16.867' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T09:19:16.867' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [GoogleAccount], [ExpiryDate], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (N'840a5778-a645-49d7-9d1d-c7d020c21dd0', N'phanthanhdo.cntt@gmail.com', 0, N'ADGcgVaxMi9ryO0xKUBJldDK0MxclNZzidaCpEY03eLmJGTKhRGiklkYg0XollXKDA==', N'8bf6d9d8-72a2-40c2-b79d-4dee8df89d39', NULL, 0, 0, NULL, 1, 0, N'phanthanhdo.cntt@gmail.com', NULL, NULL, 0, CAST(N'2017-05-11T09:37:02.840' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T09:37:02.840' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [GoogleAccount], [ExpiryDate], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (N'921a40e4-cb8d-430a-b8c7-bdc305e19236', N'huyennttfi@gmail.com', 0, N'AEojQfMQrhFKPNh9zlFjbR92hb6sfPmu0E/QKLipkMcChvKsi1+bTOhCcPvYi/wC/g==', N'd8556831-0530-4488-9598-02802c4b9084', NULL, 0, 0, NULL, 1, 0, N'huyennttfi@gmail.com', NULL, NULL, 0, CAST(N'2017-05-11T09:35:30.987' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T09:35:30.987' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [GoogleAccount], [ExpiryDate], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (N'98fab595-29c0-419f-b5f4-bd057d536622', N'tantp@vla.vn', 0, N'ALfmDWudXJuVy5lpkMTVdq2/wpj4B1Zqopf1Gj5smkKCqz/AHHkYVws/o+0SZvuZJA==', N'2ea5b28b-a18e-4541-9d6e-5ebe5f74f5c9', NULL, 0, 0, NULL, 1, 0, N'tantp@vla.vn', NULL, NULL, 0, CAST(N'2017-05-11T09:36:39.117' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T09:36:39.117' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [GoogleAccount], [ExpiryDate], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (N'a5849eb3-eda3-405d-96fd-9b12515beb1d', N'tungnt@vla.vn', 0, N'AAvgh5HJ+KZB028JdTR4Wj5yXaY4sn5uvb+oo+TRR5KKqMXq/0FnI6iLAbzE2LgjnA==', N'a98d9600-6e84-47bf-9b2b-b381997e730c', NULL, 0, 0, NULL, 1, 0, N'tungnt@vla.vn', NULL, NULL, 0, CAST(N'2017-05-11T09:21:17.647' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T09:21:17.647' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [GoogleAccount], [ExpiryDate], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (N'b6f7cd2f-d0b5-48bc-8218-aece03e4d1e9', N'nguyenh189@yahoo.com', 0, N'ANoLykZBNtC2Q3l1v5mX6/7KC1iQYUkotWV1FTx7s0t/xkRjyUD62UvCRCFooa8Mgg==', N'aad00e79-9574-4e33-bf8a-6b811a260cbd', NULL, 0, 0, NULL, 1, 0, N'nguyenh189@yahoo.com', NULL, NULL, 0, CAST(N'2017-05-11T09:29:24.540' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T09:29:24.540' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [GoogleAccount], [ExpiryDate], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (N'bbad31f0-1221-48f9-a922-60b7f63bc094', N'thang6728@yaoo.com', 0, N'AGytXLoygsmfMHBr/IQfWcfDve8Opk2f4B3ZIlbmRRXRdpEixfhpWs1P+WktnUeKEQ==', N'0a0e0afa-e896-40b2-9fd9-d6a9be57edd0', NULL, 0, 0, NULL, 1, 0, N'thang6728@yaoo.com', NULL, NULL, 0, CAST(N'2017-05-11T09:50:26.940' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T09:50:26.940' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [GoogleAccount], [ExpiryDate], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (N'bff01931-4028-4d84-a7e1-ddaa2acc41cc', N'manhdv@vla.vn', 0, N'ANDEjjjaxeWE4zqkTm+dCmkxQvq1T2Ah1zxGIyF9aXvUWzce/nwQbdWX8E6ZWYh3kw==', N'ede633b8-aeea-4724-941e-48a47acfee01', NULL, 0, 0, NULL, 1, 0, N'manhdv@vla.vn', NULL, NULL, 0, CAST(N'2017-05-11T09:19:48.880' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T09:19:48.880' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [GoogleAccount], [ExpiryDate], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (N'c2beb595-7677-492c-ae90-3acfb3b7bdd9', N'thiendv@vla.vn', 0, N'AKEq7iB2OmNKMGWr4BWZEuS+hJPmJimnOy0P++57XE1SiMgaKYl2gteBYsCk0f2GEA==', N'db0dacdf-b3b2-429f-8b51-07dc782ae0e6', NULL, 0, 0, NULL, 1, 0, N'thiendv@vla.vn', NULL, NULL, 0, CAST(N'2017-05-11T09:45:38.593' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T09:45:38.593' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [GoogleAccount], [ExpiryDate], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (N'c2d2c237-e50a-4f26-ba31-9c8ff446c2de', N'hathinhung92@gmail.com', 0, N'AHQqxcHa3Z3D11hO0LpOJ+sb1SeSmb8olf+CYbk1aiOHx7zpLr47t/56N7wekEJ7yg==', N'5119e493-69ec-40f1-919b-bc39a71959c6', NULL, 0, 0, NULL, 1, 0, N'hathinhung92@gmail.com', NULL, NULL, 0, CAST(N'2017-05-11T09:20:23.990' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T09:20:23.990' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [GoogleAccount], [ExpiryDate], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (N'c62f28c7-9ddc-4696-9e8e-69ef901bb7f6', N'hoanghonghuong2@gmail.com', 0, N'ADGH3bTA0Uw/c2+CxZ+86yHZvuvZ7AiMPQquZ6G0AgzTxLceTwbH7Q9MePWvCN43Jw==', N'cb94ece6-52c7-4e2f-91da-feca3e5b5ba8', NULL, 0, 0, NULL, 1, 0, N'hoanghonghuong2@gmail.com', NULL, NULL, 0, CAST(N'2017-05-11T09:33:53.627' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T09:33:53.627' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [GoogleAccount], [ExpiryDate], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (N'c8c14ec0-8842-4424-b026-3507588e873a', N'huyenlucky@yahoo.com', 0, N'ANLiTmIwFZFoV53coU3BmKCg5mG7TGqAN096QVE5/DK0U/0T7HXmMA4krKrSSB2gPg==', N'358604a9-9b5e-487c-92d6-322b136e4d1a', NULL, 0, 0, NULL, 1, 0, N'huyenlucky@yahoo.com', NULL, NULL, 0, CAST(N'2017-05-11T09:26:10.803' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T09:26:10.803' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [GoogleAccount], [ExpiryDate], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (N'c8df8541-be47-4a62-b217-e4da7bf89f7a', N'duyhungdu@gmail.com', 0, N'ABtEckyCvDUilng4lh7x2v5ASMMVVlwQ4Ri/7Vz9gQO4v/JFdxXehtSe/4KhssPzHA==', N'784ee183-252c-4e20-add2-f3dfdbd71ff7', NULL, 0, 0, NULL, 1, 0, N'duyhungdu@gmail.com', NULL, NULL, 0, CAST(N'2017-04-03T11:33:52.490' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-04-03T11:35:20.860' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [GoogleAccount], [ExpiryDate], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (N'dade1a28-0c41-40ba-82d3-23e080a6ee92', N'phananhtu1979@gmail.com', 0, N'APS5Tblad65P2dql6EzI867R1BLx+FePHmJiP373bPgIhllxl2P1vUnLhto+t6nneA==', N'3a965f75-8b4d-4ee3-8821-4ea5dff0ab4f', NULL, 0, 0, NULL, 1, 0, N'phananhtu1979@gmail.com', NULL, NULL, 0, CAST(N'2017-05-11T09:38:28.750' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T09:38:28.750' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [GoogleAccount], [ExpiryDate], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (N'fcf58397-bcd6-4152-9ad9-dccb86a7b8d1', N'thinhdv@vla.vn', 0, N'AKtJLPtoFMGrnTqYbarK14Lpo1uxBxeiClNxjAGMloptENBSaCZDONP8XZlnp2ptvQ==', N'ce948f6c-8a14-4a0d-a049-db87d085ade4', NULL, 0, 0, NULL, 1, 0, N'thinhdv@vla.vn', NULL, NULL, 0, CAST(N'2017-05-11T09:20:07.107' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T09:20:07.107' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [GoogleAccount], [ExpiryDate], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (N'ffe3f5af-3833-4426-8375-7209f015f785', N'hongnq@heid.vn', 0, N'AKqfJtLpZIapwVSg3bu89yEZQ//AQZu+DKo8OSgXgYXq7qgKESdUlrmn6Y6zajJoWg==', N'e9af1751-73dd-4b0e-8f9b-7179e2584cd1', NULL, 0, 0, NULL, 1, 0, N'hongnq@heid.vn', NULL, NULL, 0, CAST(N'2017-05-11T09:31:41.017' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T09:31:41.017' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
SET IDENTITY_INSERT [doc].[DocumentAttachment] ON 

INSERT [doc].[DocumentAttachment] ([Id], [FileName], [FilePath], [DocumentId], [DepartmentId], [ReceivedDocument], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (1, N'0001.pdf', N'/CQVP/0001.pdf', 2, 4, 0, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'bbad31f0-1221-48f9-a922-60b7f63bc094', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'bbad31f0-1221-48f9-a922-60b7f63bc094')
SET IDENTITY_INSERT [doc].[DocumentAttachment] OFF
SET IDENTITY_INSERT [doc].[DocumentDelivered] ON 

INSERT [doc].[DocumentDelivered] ([Id], [DocumentNumber], [Title], [DocumentDate], [DeliveredDate], [DepartmentId], [ExternalReceiveDivisionId], [ExternalReceiveDivision], [RecipientsDivision], [SignedById], [SignedBy], [DocumentTypeId], [NumberOfCopies], [NumberOfPages], [SecretLevel], [UrgencyLevel], [Note], [OriginalSavingPlace], [LegalDocument], [AttachmentName], [AttachmentPath], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (2, N'01/2017/QĐ-CQVP', N'V/v dừng cấp nước khu vực 81 THĐ', CAST(N'2017-05-11T00:00:00' AS SmallDateTime), CAST(N'2017-05-11T00:00:00' AS SmallDateTime), 4, NULL, NULL, N'Ban Tổng Giám đốc, Ban Tổng hợp Đối ngoại, Vũ Đăng Quang Trung, Nguyễn Hồng Nhung, Công ty Cổ phần Đầu tư và Phát triển Công nghệ Văn Lang, Nhà xuất bản Giáo dục tại Hà Nội', 1, N'Nguyễn Đức Thái', 17, 1, 1, 1, 1, N'', N'VP', 0, N'0001.pdf', N'0001.pdf', 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
SET IDENTITY_INSERT [doc].[DocumentDelivered] OFF
SET IDENTITY_INSERT [doc].[DocumentReceived] ON 

INSERT [doc].[DocumentReceived] ([Id], [DocumentNumber], [ReceivedNumber], [Title], [DocumentDate], [ReceivedDate], [DepartmentId], [ExternalFromDivisionId], [ExternalFromDivision], [RecipientsDivision], [SignedById], [SignedBy], [DocumentTypeId], [AddedDocumentBook], [DocumentBookAddedOn], [DocumentBookAddedBy], [NumberOfCopies], [NumberOfPages], [SecretLevel], [UrgencyLevel], [Note], [OriginalSavingPlace], [LegalDocument], [AttachmentName], [AttachmentPath], [DeliveredDocumentId], [ReceivedDocumentId], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (1, N'01/2017/QĐ-CQVP', NULL, N'V/v dừng cấp nước khu vực 81 THĐ', CAST(N'2017-05-11T00:00:00' AS SmallDateTime), CAST(N'2017-05-11T00:00:00' AS SmallDateTime), 5, NULL, NULL, NULL, NULL, N'Nguyễn Đức Thái', 17, 0, NULL, NULL, 1, 1, 1, 1, NULL, N'VP', 0, N'0001.pdf', N'/CQVP/0001.pdf', 2, NULL, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'bbad31f0-1221-48f9-a922-60b7f63bc094', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'bbad31f0-1221-48f9-a922-60b7f63bc094')
INSERT [doc].[DocumentReceived] ([Id], [DocumentNumber], [ReceivedNumber], [Title], [DocumentDate], [ReceivedDate], [DepartmentId], [ExternalFromDivisionId], [ExternalFromDivision], [RecipientsDivision], [SignedById], [SignedBy], [DocumentTypeId], [AddedDocumentBook], [DocumentBookAddedOn], [DocumentBookAddedBy], [NumberOfCopies], [NumberOfPages], [SecretLevel], [UrgencyLevel], [Note], [OriginalSavingPlace], [LegalDocument], [AttachmentName], [AttachmentPath], [DeliveredDocumentId], [ReceivedDocumentId], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (2, N'01/2017/QĐ-CQVP', NULL, N'V/v dừng cấp nước khu vực 81 THĐ', CAST(N'2017-05-11T00:00:00' AS SmallDateTime), CAST(N'2017-05-11T00:00:00' AS SmallDateTime), 15, NULL, NULL, NULL, NULL, N'Nguyễn Đức Thái', 17, 0, NULL, NULL, 1, 1, 1, 1, NULL, N'VP', 0, N'0001.pdf', N'/CQVP/0001.pdf', 2, NULL, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'bbad31f0-1221-48f9-a922-60b7f63bc094', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'bbad31f0-1221-48f9-a922-60b7f63bc094')
SET IDENTITY_INSERT [doc].[DocumentReceived] OFF
SET IDENTITY_INSERT [doc].[DocumentRecipent] ON 

INSERT [doc].[DocumentRecipent] ([Id], [DocumentId], [UserId], [DepartmentId], [ReceivedDocument], [Forwarded], [Assigned], [AddedDocumentBook], [ForSending], [CreatedOn], [CreatedBy]) VALUES (1, 2, N'bbad31f0-1221-48f9-a922-60b7f63bc094', NULL, 0, 0, 0, 0, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'bbad31f0-1221-48f9-a922-60b7f63bc094')
INSERT [doc].[DocumentRecipent] ([Id], [DocumentId], [UserId], [DepartmentId], [ReceivedDocument], [Forwarded], [Assigned], [AddedDocumentBook], [ForSending], [CreatedOn], [CreatedBy]) VALUES (2, 2, N'69fb3b53-994f-4d4c-b951-6b6406945178', NULL, 0, 0, 0, 0, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'bbad31f0-1221-48f9-a922-60b7f63bc094')
INSERT [doc].[DocumentRecipent] ([Id], [DocumentId], [UserId], [DepartmentId], [ReceivedDocument], [Forwarded], [Assigned], [AddedDocumentBook], [ForSending], [CreatedOn], [CreatedBy]) VALUES (3, 2, N'2e9080b7-1154-4df0-8cad-9996d7f752cf', NULL, 0, 0, 0, 0, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'bbad31f0-1221-48f9-a922-60b7f63bc094')
INSERT [doc].[DocumentRecipent] ([Id], [DocumentId], [UserId], [DepartmentId], [ReceivedDocument], [Forwarded], [Assigned], [AddedDocumentBook], [ForSending], [CreatedOn], [CreatedBy]) VALUES (4, 2, NULL, 30, 0, 0, 0, 0, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'bbad31f0-1221-48f9-a922-60b7f63bc094')
INSERT [doc].[DocumentRecipent] ([Id], [DocumentId], [UserId], [DepartmentId], [ReceivedDocument], [Forwarded], [Assigned], [AddedDocumentBook], [ForSending], [CreatedOn], [CreatedBy]) VALUES (5, 2, NULL, 32, 0, 0, 0, 0, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'bbad31f0-1221-48f9-a922-60b7f63bc094')
INSERT [doc].[DocumentRecipent] ([Id], [DocumentId], [UserId], [DepartmentId], [ReceivedDocument], [Forwarded], [Assigned], [AddedDocumentBook], [ForSending], [CreatedOn], [CreatedBy]) VALUES (6, 2, NULL, 5, 0, 0, 0, 0, 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'bbad31f0-1221-48f9-a922-60b7f63bc094')
INSERT [doc].[DocumentRecipent] ([Id], [DocumentId], [UserId], [DepartmentId], [ReceivedDocument], [Forwarded], [Assigned], [AddedDocumentBook], [ForSending], [CreatedOn], [CreatedBy]) VALUES (7, 2, NULL, 15, 0, 0, 0, 0, 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'bbad31f0-1221-48f9-a922-60b7f63bc094')
SET IDENTITY_INSERT [doc].[DocumentRecipent] OFF
SET IDENTITY_INSERT [doc].[DocumentSignedBy] ON 

INSERT [doc].[DocumentSignedBy] ([Id], [FullName], [Position], [DepartmentId], [ReceivedDocument], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (3, N'Mạc Văn Thiện', N'CT Hội đồng thành viên', NULL, 1, 1, 0, CAST(N'2017-02-23T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-02-23T16:25:08.050' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [doc].[DocumentSignedBy] ([Id], [FullName], [Position], [DepartmentId], [ReceivedDocument], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (6, N'Vũ Văn Hùng', N'Tổng Giám Đốc', NULL, 0, 1, 0, CAST(N'2017-02-23T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-02-23T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a\')
INSERT [doc].[DocumentSignedBy] ([Id], [FullName], [Position], [DepartmentId], [ReceivedDocument], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (7, N'Hoàng Lê Bách', N'Giám Đốc', NULL, 0, 1, 1, CAST(N'2017-02-23T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-02-23T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [doc].[DocumentSignedBy] ([Id], [FullName], [Position], [DepartmentId], [ReceivedDocument], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (8, N'sample string 2', N'sample string 3', NULL, 1, 1, 1, CAST(N'2017-03-02T16:55:10.657' AS DateTime), N'sample string 8', CAST(N'2017-03-02T16:55:10.657' AS DateTime), N'sample string 10')
INSERT [doc].[DocumentSignedBy] ([Id], [FullName], [Position], [DepartmentId], [ReceivedDocument], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (9, N'sample string 2', N'sample string 3', NULL, 1, 1, 1, CAST(N'2017-03-02T16:55:10.657' AS DateTime), N'sample string 8', CAST(N'2017-03-02T16:55:10.657' AS DateTime), N'sample string 10')
INSERT [doc].[DocumentSignedBy] ([Id], [FullName], [Position], [DepartmentId], [ReceivedDocument], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (10, N'sample string 2', N'sample string 3', NULL, 1, 1, 1, CAST(N'2017-03-02T16:55:10.657' AS DateTime), N'sample string 8', CAST(N'2017-03-02T16:55:10.657' AS DateTime), N'sample string 10')
INSERT [doc].[DocumentSignedBy] ([Id], [FullName], [Position], [DepartmentId], [ReceivedDocument], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (11, N'sample string 2', N'sample string 3', NULL, 1, 1, 1, CAST(N'2017-03-02T16:55:10.657' AS DateTime), N'sample string 8', CAST(N'2017-03-02T16:55:10.657' AS DateTime), N'sample string 10')
INSERT [doc].[DocumentSignedBy] ([Id], [FullName], [Position], [DepartmentId], [ReceivedDocument], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (12, N'Lê Hoài Nam', N'Giám đốc', NULL, 1, 1, 0, CAST(N'2017-03-02T00:00:00.000' AS DateTime), N'7251adb7-9b6b-4cbd-a21f-a6ecee7598b9', CAST(N'2017-03-02T00:00:00.000' AS DateTime), N'7251adb7-9b6b-4cbd-a21f-a6ecee7598b9')
INSERT [doc].[DocumentSignedBy] ([Id], [FullName], [Position], [DepartmentId], [ReceivedDocument], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (13, N'Hoàng Văn Thụ', N'Giám đốc', 3, 1, 1, 1, CAST(N'2017-03-02T00:00:00.000' AS DateTime), N'7251adb7-9b6b-4cbd-a21f-a6ecee7598b9', CAST(N'2017-03-02T00:00:00.000' AS DateTime), N'7251adb7-9b6b-4cbd-a21f-a6ecee7598b9')
INSERT [doc].[DocumentSignedBy] ([Id], [FullName], [Position], [DepartmentId], [ReceivedDocument], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (14, N'Hoàng Văn Thụ', N'Giám đốc', 3, 1, 0, 0, CAST(N'2017-03-02T00:00:00.000' AS DateTime), N'7251adb7-9b6b-4cbd-a21f-a6ecee7598b9', CAST(N'2017-03-02T00:00:00.000' AS DateTime), N'7251adb7-9b6b-4cbd-a21f-a6ecee7598b9')
INSERT [doc].[DocumentSignedBy] ([Id], [FullName], [Position], [DepartmentId], [ReceivedDocument], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (15, N'Nguyễn Thanh Sơn', N'GĐ NXBGDVN', 1, 0, 1, 1, CAST(N'2017-03-07T03:41:48.457' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-03-07T03:41:48.457' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [doc].[DocumentSignedBy] ([Id], [FullName], [Position], [DepartmentId], [ReceivedDocument], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (16, N'Dư Duy Hưng', N'Tổng giám đốc', 1, 1, 1, 0, CAST(N'2017-03-14T03:15:14.243' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-03-14T03:15:14.243' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
SET IDENTITY_INSERT [doc].[DocumentSignedBy] OFF
SET IDENTITY_INSERT [doc].[DocumentType] ON 

INSERT [doc].[DocumentType] ([Id], [Code], [Title], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (17, N'QD', N'Quyết định', 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [doc].[DocumentType] ([Id], [Code], [Title], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (18, N'TB', N'Thông báo', 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
SET IDENTITY_INSERT [doc].[DocumentType] OFF
SET IDENTITY_INSERT [organiz].[Department] ON 

INSERT [organiz].[Department] ([Id], [Code], [Name], [ShortName], [Root], [ParentId], [Order], [Address], [PhoneNumber], [Fax], [TaxNumber], [BankName], [BankAccountNumber], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (3, N'NXBGD', N'Nhà xuất bản Giáo dục Việt Nam', N'NXBGD', 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, CAST(N'2017-01-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-01-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Department] ([Id], [Code], [Name], [ShortName], [Root], [ParentId], [Order], [Address], [PhoneNumber], [Fax], [TaxNumber], [BankName], [BankAccountNumber], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (4, N'CQVP', N'Cơ quan văn phòng', N'CQVP', 1, 3, 1, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, CAST(N'2017-01-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-01-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Department] ([Id], [Code], [Name], [ShortName], [Root], [ParentId], [Order], [Address], [PhoneNumber], [Fax], [TaxNumber], [BankName], [BankAccountNumber], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (5, N'NHN', N'Nhà xuất bản Giáo dục tại TP. Hà Nội', N'NHN', 1, 3, 2, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, CAST(N'2017-01-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-01-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Department] ([Id], [Code], [Name], [ShortName], [Root], [ParentId], [Order], [Address], [PhoneNumber], [Fax], [TaxNumber], [BankName], [BankAccountNumber], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (6, N'NDN', N'Nhà xuất bản Giáo dục tại TP. Đà Nẵng', N'NDN', 1, 3, 3, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, CAST(N'2017-01-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-01-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Department] ([Id], [Code], [Name], [ShortName], [Root], [ParentId], [Order], [Address], [PhoneNumber], [Fax], [TaxNumber], [BankName], [BankAccountNumber], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (7, N'NHCM', N'Nhà xuất bản Giáo dục tại TP. Hồ chí Minh', N'NHCM', 1, 3, 4, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, CAST(N'2017-01-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-01-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Department] ([Id], [Code], [Name], [ShortName], [Root], [ParentId], [Order], [Address], [PhoneNumber], [Fax], [TaxNumber], [BankName], [BankAccountNumber], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (8, N'NCT', N'Nhà xuất bản Giáo dục tại TP. Cần thơ', N'NCT', 1, 3, 5, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, CAST(N'2017-01-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-01-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Department] ([Id], [Code], [Name], [ShortName], [Root], [ParentId], [Order], [Address], [PhoneNumber], [Fax], [TaxNumber], [BankName], [BankAccountNumber], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (9, N'RITEM', N'Viện nghiên cứu Sách và Học liệu Giáo dục', N'RITEM', 1, 3, 6, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, CAST(N'2017-01-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-01-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Department] ([Id], [Code], [Name], [ShortName], [Root], [ParentId], [Order], [Address], [PhoneNumber], [Fax], [TaxNumber], [BankName], [BankAccountNumber], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (11, N'CGD', N'Trung tâm Công nghệ Giáo dục', N'CGD', 1, 3, 7, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, CAST(N'2017-01-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-01-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Department] ([Id], [Code], [Name], [ShortName], [Root], [ParentId], [Order], [Address], [PhoneNumber], [Fax], [TaxNumber], [BankName], [BankAccountNumber], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (12, N'HEPS', N'Công ty Cổ phần Dịch vụ Xuất bản Giáo dục Hà Nội', N'HEPS', 1, 3, 8, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, CAST(N'2017-01-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-01-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Department] ([Id], [Code], [Name], [ShortName], [Root], [ParentId], [Order], [Address], [PhoneNumber], [Fax], [TaxNumber], [BankName], [BankAccountNumber], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (13, N'DEPSCO', N'Công ty Cổ phần Dịch vụ Xuất bản Giáo dục Đà Nẵng', N'DEPSCO', 1, 3, 9, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, CAST(N'2017-01-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-01-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Department] ([Id], [Code], [Name], [ShortName], [Root], [ParentId], [Order], [Address], [PhoneNumber], [Fax], [TaxNumber], [BankName], [BankAccountNumber], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (14, N'GIAEP', N'Công ty Cổ phần Dịch vụ Xuất bản Giáo dục Gia định', N'GIAEP', 1, 3, 10, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, CAST(N'2017-01-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-01-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Department] ([Id], [Code], [Name], [ShortName], [Root], [ParentId], [Order], [Address], [PhoneNumber], [Fax], [TaxNumber], [BankName], [BankAccountNumber], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (15, N'VLA', N'Công ty Cổ phần Đầu tư và Phát triển Công nghệ Văn Lang', N'VLA', 1, 3, 11, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, CAST(N'2017-01-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-01-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Department] ([Id], [Code], [Name], [ShortName], [Root], [ParentId], [Order], [Address], [PhoneNumber], [Fax], [TaxNumber], [BankName], [BankAccountNumber], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (17, N'NHN01', N'Ban Giám đốc', N'BGD', 0, 5, 1, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, CAST(N'2017-04-24T10:58:59.197' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-04-24T10:58:59.197' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Department] ([Id], [Code], [Name], [ShortName], [Root], [ParentId], [Order], [Address], [PhoneNumber], [Fax], [TaxNumber], [BankName], [BankAccountNumber], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (18, N'NHN02', N'Phòng Kế toán - Tài vụ', N'KTTV', 0, 5, 2, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, CAST(N'2017-04-24T10:59:33.490' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-04-24T10:59:33.490' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Department] ([Id], [Code], [Name], [ShortName], [Root], [ParentId], [Order], [Address], [PhoneNumber], [Fax], [TaxNumber], [BankName], [BankAccountNumber], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (19, N'NHN03', N'Phòng Kế hoạch In - PH - KV', N'IN-PH-KV', 0, 5, 3, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, CAST(N'2017-04-24T10:58:59.197' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-04-24T10:58:59.197' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Department] ([Id], [Code], [Name], [ShortName], [Root], [ParentId], [Order], [Address], [PhoneNumber], [Fax], [TaxNumber], [BankName], [BankAccountNumber], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (20, N'NHN04', N'Phòng kiểm định chất lượng và chống in lậu', N'KDCT', 0, 5, 4, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, CAST(N'2017-04-24T10:59:33.490' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-04-24T10:59:33.490' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Department] ([Id], [Code], [Name], [ShortName], [Root], [ParentId], [Order], [Address], [PhoneNumber], [Fax], [TaxNumber], [BankName], [BankAccountNumber], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (21, N'NHN05', N'Phòng Quản lí xuất bản', N'QLXB', 0, 5, 5, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, CAST(N'2017-04-24T10:58:59.197' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-04-24T10:58:59.197' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Department] ([Id], [Code], [Name], [ShortName], [Root], [ParentId], [Order], [Address], [PhoneNumber], [Fax], [TaxNumber], [BankName], [BankAccountNumber], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (22, N'NHN06', N'Phòng Tổng hợp', N'TH', 0, 5, 6, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, CAST(N'2017-04-24T10:58:59.197' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-04-24T10:58:59.197' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Department] ([Id], [Code], [Name], [ShortName], [Root], [ParentId], [Order], [Address], [PhoneNumber], [Fax], [TaxNumber], [BankName], [BankAccountNumber], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (23, N'NHN07', N'Phòng Thư viện', N'TV', 0, 5, 7, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, CAST(N'2017-04-24T10:59:33.490' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-04-24T10:59:33.490' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Department] ([Id], [Code], [Name], [ShortName], [Root], [ParentId], [Order], [Address], [PhoneNumber], [Fax], [TaxNumber], [BankName], [BankAccountNumber], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (24, N'NHN08', N'Phòng TC - HC - QT', N'TC-HC-QT', 0, 5, 8, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, CAST(N'2017-04-24T10:58:59.197' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-04-24T10:58:59.197' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Department] ([Id], [Code], [Name], [ShortName], [Root], [ParentId], [Order], [Address], [PhoneNumber], [Fax], [TaxNumber], [BankName], [BankAccountNumber], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (25, N'VLA01', N'Ban Giám đốc', N'BGD', 0, 15, 1, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, CAST(N'2017-04-24T10:58:59.197' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-04-24T10:58:59.197' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Department] ([Id], [Code], [Name], [ShortName], [Root], [ParentId], [Order], [Address], [PhoneNumber], [Fax], [TaxNumber], [BankName], [BankAccountNumber], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (26, N'VLA02', N'Phòng KT - TC - HC', N'KT-TC-HC', 0, 15, 2, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, CAST(N'2017-04-24T10:59:33.490' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-04-24T10:59:33.490' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Department] ([Id], [Code], [Name], [ShortName], [Root], [ParentId], [Order], [Address], [PhoneNumber], [Fax], [TaxNumber], [BankName], [BankAccountNumber], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (27, N'VLA03', N'Phòng Phát triển Phần mềm', N'PTPM', 0, 15, 3, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, CAST(N'2017-04-24T10:58:59.197' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-04-24T10:58:59.197' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Department] ([Id], [Code], [Name], [ShortName], [Root], [ParentId], [Order], [Address], [PhoneNumber], [Fax], [TaxNumber], [BankName], [BankAccountNumber], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (28, N'VLA04', N'Phòng Giải pháp Ứng dụng', N'GPUD', 0, 15, 4, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, CAST(N'2017-04-24T10:59:33.490' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-04-24T10:59:33.490' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Department] ([Id], [Code], [Name], [ShortName], [Root], [ParentId], [Order], [Address], [PhoneNumber], [Fax], [TaxNumber], [BankName], [BankAccountNumber], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (29, N'VLA05', N'Phòng Hệ thống', N'HT', 0, 15, 5, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, CAST(N'2017-04-24T10:58:59.197' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-04-24T10:58:59.197' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Department] ([Id], [Code], [Name], [ShortName], [Root], [ParentId], [Order], [Address], [PhoneNumber], [Fax], [TaxNumber], [BankName], [BankAccountNumber], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (30, N'CQVP01', N'Ban Tổng Giám đốc', N'BTGD', 0, 4, 1, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, CAST(N'2017-04-24T10:58:59.197' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-04-24T10:58:59.197' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Department] ([Id], [Code], [Name], [ShortName], [Root], [ParentId], [Order], [Address], [PhoneNumber], [Fax], [TaxNumber], [BankName], [BankAccountNumber], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (31, N'CQVP02', N'Ban Tổng hợp Đối ngoại', N'THĐN', 0, 4, 2, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, CAST(N'2017-04-24T10:59:33.490' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-04-24T10:59:33.490' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Department] ([Id], [Code], [Name], [ShortName], [Root], [ParentId], [Order], [Address], [PhoneNumber], [Fax], [TaxNumber], [BankName], [BankAccountNumber], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (32, N'CQVP03', N'Ban Tổ chức - Nhân sự', N'TCNS', 0, 4, 3, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, CAST(N'2017-04-24T10:58:59.197' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-04-24T10:58:59.197' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Department] ([Id], [Code], [Name], [ShortName], [Root], [ParentId], [Order], [Address], [PhoneNumber], [Fax], [TaxNumber], [BankName], [BankAccountNumber], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (33, N'CQVP04', N'Ban Quản trị - Hành chính', N'QTHC', 0, 4, 4, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, CAST(N'2017-04-24T10:58:59.197' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-04-24T10:58:59.197' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
SET IDENTITY_INSERT [organiz].[Department] OFF
INSERT [organiz].[DepartmentStaffs] ([DepartmentId], [StaffId], [Position], [MainDepartment], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (17, 13, N'Phó Giám đốc', 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[DepartmentStaffs] ([DepartmentId], [StaffId], [Position], [MainDepartment], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (17, 14, N'Phó Giám đốc', 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[DepartmentStaffs] ([DepartmentId], [StaffId], [Position], [MainDepartment], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (17, 15, N'Kế toán trưởng', 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[DepartmentStaffs] ([DepartmentId], [StaffId], [Position], [MainDepartment], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (17, 16, N'Phó Giám đốc', 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[DepartmentStaffs] ([DepartmentId], [StaffId], [Position], [MainDepartment], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (24, 17, N'Trưởng phòng', 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[DepartmentStaffs] ([DepartmentId], [StaffId], [Position], [MainDepartment], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (24, 18, N'Chuyên viên', 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[DepartmentStaffs] ([DepartmentId], [StaffId], [Position], [MainDepartment], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (24, 35, N'Phó phòng', 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[DepartmentStaffs] ([DepartmentId], [StaffId], [Position], [MainDepartment], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (25, 19, N'Phó Giám đốc phụ trách', 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[DepartmentStaffs] ([DepartmentId], [StaffId], [Position], [MainDepartment], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (26, 20, N'Trưởng phòng', 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[DepartmentStaffs] ([DepartmentId], [StaffId], [Position], [MainDepartment], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (26, 21, N'Chuyên viên', 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[DepartmentStaffs] ([DepartmentId], [StaffId], [Position], [MainDepartment], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (26, 22, N'Chuyên viên', 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[DepartmentStaffs] ([DepartmentId], [StaffId], [Position], [MainDepartment], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (27, 23, N'Giám đốc bộ phận', 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[DepartmentStaffs] ([DepartmentId], [StaffId], [Position], [MainDepartment], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (27, 24, N'Phó phòng', 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[DepartmentStaffs] ([DepartmentId], [StaffId], [Position], [MainDepartment], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (27, 25, N'Chuyên viên', 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[DepartmentStaffs] ([DepartmentId], [StaffId], [Position], [MainDepartment], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (27, 26, N'Chuyên viên', 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[DepartmentStaffs] ([DepartmentId], [StaffId], [Position], [MainDepartment], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (28, 31, N'Giám đốc bộ phận', 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[DepartmentStaffs] ([DepartmentId], [StaffId], [Position], [MainDepartment], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (28, 32, N'Chuyên viên', 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[DepartmentStaffs] ([DepartmentId], [StaffId], [Position], [MainDepartment], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (28, 33, N'Chuyên viên', 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[DepartmentStaffs] ([DepartmentId], [StaffId], [Position], [MainDepartment], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (28, 34, N'Chuyên viên', 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[DepartmentStaffs] ([DepartmentId], [StaffId], [Position], [MainDepartment], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (29, 27, N'Giám đốc bộ phận', 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[DepartmentStaffs] ([DepartmentId], [StaffId], [Position], [MainDepartment], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (29, 28, N'Chuyên viên', 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[DepartmentStaffs] ([DepartmentId], [StaffId], [Position], [MainDepartment], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (29, 29, N'Chuyên viên', 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[DepartmentStaffs] ([DepartmentId], [StaffId], [Position], [MainDepartment], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (29, 30, N'Chuyên viên', 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[DepartmentStaffs] ([DepartmentId], [StaffId], [Position], [MainDepartment], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (30, 1, N'Chủ tịch hội đồng Thành viên', 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[DepartmentStaffs] ([DepartmentId], [StaffId], [Position], [MainDepartment], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (30, 2, N'Phó Tổng Giám đốc phụ trách', 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[DepartmentStaffs] ([DepartmentId], [StaffId], [Position], [MainDepartment], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (30, 3, N'Phó Tổng Giám đốc kiêm Giám đốc Tài chính', 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[DepartmentStaffs] ([DepartmentId], [StaffId], [Position], [MainDepartment], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (31, 4, N'Phó Chánh văn phòng kiêm Trưởng ban', 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[DepartmentStaffs] ([DepartmentId], [StaffId], [Position], [MainDepartment], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (31, 6, N'Phó ban', 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[DepartmentStaffs] ([DepartmentId], [StaffId], [Position], [MainDepartment], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (31, 7, N'Phó ban', 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[DepartmentStaffs] ([DepartmentId], [StaffId], [Position], [MainDepartment], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (32, 8, N'Phó ban', 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[DepartmentStaffs] ([DepartmentId], [StaffId], [Position], [MainDepartment], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (32, 9, N'Phó ban', 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[DepartmentStaffs] ([DepartmentId], [StaffId], [Position], [MainDepartment], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (32, 10, N'Giám đốc Nhân sự', 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[DepartmentStaffs] ([DepartmentId], [StaffId], [Position], [MainDepartment], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (33, 11, N'Trưởng ban', 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[DepartmentStaffs] ([DepartmentId], [StaffId], [Position], [MainDepartment], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (33, 12, N'Chuyên viên', 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
SET IDENTITY_INSERT [organiz].[Staff] ON 

INSERT [organiz].[Staff] ([Id], [StaffCode], [FirstName], [LastName], [FullName], [UserId], [Email], [PhoneNumber], [DateOfBirth], [Gender], [Address], [Avatar], [Order], [Leader], [SeniorLeader], [SignedBy], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (1, N'00001', N'Thái', N'Nguyễn Đức', N'Nguyễn Đức Thái', NULL, N'ndthai@moet.gov.vn', N'0975.888.889', CAST(N'1962-05-06T00:00:00.000' AS DateTime), 1, N'81 Trần Hưng Đạo Hoàn Kiếm Hà Nội', NULL, 0, 1, 1, 1, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Staff] ([Id], [StaffCode], [FirstName], [LastName], [FullName], [UserId], [Email], [PhoneNumber], [DateOfBirth], [Gender], [Address], [Avatar], [Order], [Leader], [SeniorLeader], [SignedBy], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (2, N'00002', N'Bách', N'Hoàng Lê', N'Hoàng Lê Bách', NULL, N'tcns_nxbgd@yahoo.com', N'0975.888.889', CAST(N'1962-05-06T00:00:00.000' AS DateTime), 1, N'81 Trần Hưng Đạo Hoàn Kiếm Hà Nội', NULL, 0, 1, 1, 1, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Staff] ([Id], [StaffCode], [FirstName], [LastName], [FullName], [UserId], [Email], [PhoneNumber], [DateOfBirth], [Gender], [Address], [Avatar], [Order], [Leader], [SeniorLeader], [SignedBy], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (3, N'00003', N'Anh', N'Lê Thành', N'Lê Thành Anh', NULL, N'ltab74@yahoo.com', N'0975.888.889', CAST(N'1962-05-06T00:00:00.000' AS DateTime), 1, N'81 Trần Hưng Đạo Hoàn Kiếm Hà Nội', NULL, 0, 1, 1, 1, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Staff] ([Id], [StaffCode], [FirstName], [LastName], [FullName], [UserId], [Email], [PhoneNumber], [DateOfBirth], [Gender], [Address], [Avatar], [Order], [Leader], [SeniorLeader], [SignedBy], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (4, N'00004', N'Anh', N'Trần Lan', N'Trần Lan Anh', NULL, N'lananhnxbgd@gmail.com', N'0975.888.889', CAST(N'1962-05-06T00:00:00.000' AS DateTime), 1, N'81 Trần Hưng Đạo Hoàn Kiếm Hà Nội', NULL, 0, 1, 1, 1, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Staff] ([Id], [StaffCode], [FirstName], [LastName], [FullName], [UserId], [Email], [PhoneNumber], [DateOfBirth], [Gender], [Address], [Avatar], [Order], [Leader], [SeniorLeader], [SignedBy], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (6, N'00005', N'Huyền', N'Ngô Thanh', N'Ngô Thanh Huyền', NULL, N'huyenlucky@yahoo.com', N'0975.888.889', CAST(N'1962-05-06T00:00:00.000' AS DateTime), 1, N'81 Trần Hưng Đạo Hoàn Kiếm Hà Nội', NULL, 0, 1, 1, 1, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Staff] ([Id], [StaffCode], [FirstName], [LastName], [FullName], [UserId], [Email], [PhoneNumber], [DateOfBirth], [Gender], [Address], [Avatar], [Order], [Leader], [SeniorLeader], [SignedBy], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (7, N'00006', N'Hiền', N'Trần Thu', N'Trần Thu Hiền', NULL, N'tranthuhien183@yahoo.com', N'0975.888.889', CAST(N'1962-05-06T00:00:00.000' AS DateTime), 1, N'81 Trần Hưng Đạo Hoàn Kiếm Hà Nội', NULL, 0, 1, 1, 1, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Staff] ([Id], [StaffCode], [FirstName], [LastName], [FullName], [UserId], [Email], [PhoneNumber], [DateOfBirth], [Gender], [Address], [Avatar], [Order], [Leader], [SeniorLeader], [SignedBy], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (8, N'00007', N'Trung', N'Vũ Đặng Quang', N'Vũ Đặng Quang Trung', NULL, N'vudangquangtrung@yahoo.com', N'0975.888.889', CAST(N'1962-05-06T00:00:00.000' AS DateTime), 1, N'81 Trần Hưng Đạo Hoàn Kiếm Hà Nội', NULL, 0, 1, 1, 1, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Staff] ([Id], [StaffCode], [FirstName], [LastName], [FullName], [UserId], [Email], [PhoneNumber], [DateOfBirth], [Gender], [Address], [Avatar], [Order], [Leader], [SeniorLeader], [SignedBy], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (9, N'00008', N'Thủy', N'Đỗ Thanh', N'Đỗ Thanh Thủy', NULL, N'tthuy27hn@yahoo.com', N'0975.888.889', CAST(N'1962-05-06T00:00:00.000' AS DateTime), 1, N'81 Trần Hưng Đạo Hoàn Kiếm Hà Nội', NULL, 0, 1, 1, 1, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Staff] ([Id], [StaffCode], [FirstName], [LastName], [FullName], [UserId], [Email], [PhoneNumber], [DateOfBirth], [Gender], [Address], [Avatar], [Order], [Leader], [SeniorLeader], [SignedBy], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (10, N'00009', N'Hằng', N'Nguyễn Thị Thu', N'Nguyễn Thị Thu Hằng', NULL, N'nguyenh189@yahoo.com', N'0975.888.889', CAST(N'1962-05-06T00:00:00.000' AS DateTime), 1, N'81 Trần Hưng Đạo Hoàn Kiếm Hà Nội', NULL, 0, 1, 1, 1, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Staff] ([Id], [StaffCode], [FirstName], [LastName], [FullName], [UserId], [Email], [PhoneNumber], [DateOfBirth], [Gender], [Address], [Avatar], [Order], [Leader], [SeniorLeader], [SignedBy], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (11, N'00010', N'Chuẩn', N'Hà Sỹ', N'Hà Sỹ Chuẩn', NULL, N'hasychuan@yahoo.com', N'0975.888.889', CAST(N'1962-05-06T00:00:00.000' AS DateTime), 1, N'81 Trần Hưng Đạo Hoàn Kiếm Hà Nội', NULL, 0, 1, 1, 1, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Staff] ([Id], [StaffCode], [FirstName], [LastName], [FullName], [UserId], [Email], [PhoneNumber], [DateOfBirth], [Gender], [Address], [Avatar], [Order], [Leader], [SeniorLeader], [SignedBy], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (12, N'00011', N'Thắng', N'Nguyễn Gia', N'Nguyễn Gia Thắng', NULL, N'thang6728@yaoo.com', N'0975.888.889', CAST(N'1962-05-06T00:00:00.000' AS DateTime), 1, N'81 Trần Hưng Đạo Hoàn Kiếm Hà Nội', NULL, 0, 1, 1, 1, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Staff] ([Id], [StaffCode], [FirstName], [LastName], [FullName], [UserId], [Email], [PhoneNumber], [DateOfBirth], [Gender], [Address], [Avatar], [Order], [Leader], [SeniorLeader], [SignedBy], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (13, N'00012', N'Phương', N'Đỗ Thị', N'Đỗ Thị Phương', NULL, N'phuonghong966@yahoo.com', N'0975.888.889', CAST(N'1962-05-06T00:00:00.000' AS DateTime), 1, N'81 Trần Hưng Đạo Hoàn Kiếm Hà Nội', NULL, 0, 1, 1, 1, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Staff] ([Id], [StaffCode], [FirstName], [LastName], [FullName], [UserId], [Email], [PhoneNumber], [DateOfBirth], [Gender], [Address], [Avatar], [Order], [Leader], [SeniorLeader], [SignedBy], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (14, N'00013', N'Anh', N'Lã Thị Vân', N'Lã Thị Vân Anh', NULL, N'anhltv@efi.vn', N'0975.888.889', CAST(N'1962-05-06T00:00:00.000' AS DateTime), 1, N'81 Trần Hưng Đạo Hoàn Kiếm Hà Nội', NULL, 0, 1, 1, 1, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Staff] ([Id], [StaffCode], [FirstName], [LastName], [FullName], [UserId], [Email], [PhoneNumber], [DateOfBirth], [Gender], [Address], [Avatar], [Order], [Leader], [SeniorLeader], [SignedBy], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (15, N'00014', N'Hạnh', N'Hoàng Thị Hồng', N'Hoàng Thị Hồng Hạnh', NULL, N'hoanghonghanh21@yahoo.com', N'0975.888.889', CAST(N'1962-05-06T00:00:00.000' AS DateTime), 1, N'81 Trần Hưng Đạo Hoàn Kiếm Hà Nội', NULL, 0, 1, 1, 1, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Staff] ([Id], [StaffCode], [FirstName], [LastName], [FullName], [UserId], [Email], [PhoneNumber], [DateOfBirth], [Gender], [Address], [Avatar], [Order], [Leader], [SeniorLeader], [SignedBy], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (16, N'00015', N'Hồng', N'Nguyễn Quốc', N'Nguyễn Quốc Hồng', NULL, N'hongnq@heid.vn', N'0975.888.889', CAST(N'1962-05-06T00:00:00.000' AS DateTime), 1, N'81 Trần Hưng Đạo Hoàn Kiếm Hà Nội', NULL, 0, 1, 1, 1, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Staff] ([Id], [StaffCode], [FirstName], [LastName], [FullName], [UserId], [Email], [PhoneNumber], [DateOfBirth], [Gender], [Address], [Avatar], [Order], [Leader], [SeniorLeader], [SignedBy], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (17, N'00016', N'Hương', N'Hoàng Hồng', N'Hoàng Hồng Hương', NULL, N'hoanghonghuong2@gmail.com', N'0975.888.889', CAST(N'1962-05-06T00:00:00.000' AS DateTime), 1, N'81 Trần Hưng Đạo Hoàn Kiếm Hà Nội', NULL, 0, 1, 1, 1, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Staff] ([Id], [StaffCode], [FirstName], [LastName], [FullName], [UserId], [Email], [PhoneNumber], [DateOfBirth], [Gender], [Address], [Avatar], [Order], [Leader], [SeniorLeader], [SignedBy], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (18, N'00017', N'Luyến', N'Vũ Thị', N'Vũ Thị Luyến', NULL, N'luyen.dh1985@gmail.com', N'0975.888.889', CAST(N'1962-05-06T00:00:00.000' AS DateTime), 1, N'81 Trần Hưng Đạo Hoàn Kiếm Hà Nội', NULL, 0, 1, 1, 1, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Staff] ([Id], [StaffCode], [FirstName], [LastName], [FullName], [UserId], [Email], [PhoneNumber], [DateOfBirth], [Gender], [Address], [Avatar], [Order], [Leader], [SeniorLeader], [SignedBy], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (19, N'00018', N'Tùng', N'Nguyễn Thanh', N'Nguyễn Thanh', NULL, N'tungnt@vla.vn', N'0975.888.889', CAST(N'1962-05-06T00:00:00.000' AS DateTime), 1, N'81 Trần Hưng Đạo Hoàn Kiếm Hà Nội', NULL, 0, 1, 1, 1, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Staff] ([Id], [StaffCode], [FirstName], [LastName], [FullName], [UserId], [Email], [PhoneNumber], [DateOfBirth], [Gender], [Address], [Avatar], [Order], [Leader], [SeniorLeader], [SignedBy], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (20, N'00019', N'Hòa', N'Hoàng Thị Xuân', N'Hoàng Thị Xuân Hòa', NULL, N'hoangxuanhoa36@yahoo.com', N'0975.888.889', CAST(N'1962-05-06T00:00:00.000' AS DateTime), 1, N'81 Trần Hưng Đạo Hoàn Kiếm Hà Nội', NULL, 0, 1, 1, 1, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Staff] ([Id], [StaffCode], [FirstName], [LastName], [FullName], [UserId], [Email], [PhoneNumber], [DateOfBirth], [Gender], [Address], [Avatar], [Order], [Leader], [SeniorLeader], [SignedBy], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (21, N'00020', N'Huyên', N'Ngô Tá', N'Ngô Tá Huyên', NULL, N'huyennttfi@gmail.com', N'0975.888.889', CAST(N'1962-05-06T00:00:00.000' AS DateTime), 1, N'81 Trần Hưng Đạo Hoàn Kiếm Hà Nội', NULL, 0, 1, 1, 1, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Staff] ([Id], [StaffCode], [FirstName], [LastName], [FullName], [UserId], [Email], [PhoneNumber], [DateOfBirth], [Gender], [Address], [Avatar], [Order], [Leader], [SeniorLeader], [SignedBy], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (22, N'00021', N'Anh', N'Phạm Tuấn', N'Phạm Tuấn Anh', NULL, N'anhpt@vla.vn', N'0975.888.889', CAST(N'1962-05-06T00:00:00.000' AS DateTime), 1, N'81 Trần Hưng Đạo Hoàn Kiếm Hà Nội', NULL, 0, 1, 1, 1, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Staff] ([Id], [StaffCode], [FirstName], [LastName], [FullName], [UserId], [Email], [PhoneNumber], [DateOfBirth], [Gender], [Address], [Avatar], [Order], [Leader], [SeniorLeader], [SignedBy], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (23, N'00022', N'Mạnh', N'Đặng Viết', N'Đặng Viết Mạnh', NULL, N'manhdv@vla.vn', N'0975.888.889', CAST(N'1962-05-06T00:00:00.000' AS DateTime), 1, N'81 Trần Hưng Đạo Hoàn Kiếm Hà Nội', NULL, 0, 1, 1, 1, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Staff] ([Id], [StaffCode], [FirstName], [LastName], [FullName], [UserId], [Email], [PhoneNumber], [DateOfBirth], [Gender], [Address], [Avatar], [Order], [Leader], [SeniorLeader], [SignedBy], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (24, N'00023', N'Thiện', N'Dương Văn', N'Dương Văn Thiện', NULL, N'thiendv@vla.vn', N'0975.888.889', CAST(N'1962-05-06T00:00:00.000' AS DateTime), 1, N'81 Trần Hưng Đạo Hoàn Kiếm Hà Nội', NULL, 0, 1, 1, 1, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Staff] ([Id], [StaffCode], [FirstName], [LastName], [FullName], [UserId], [Email], [PhoneNumber], [DateOfBirth], [Gender], [Address], [Avatar], [Order], [Leader], [SeniorLeader], [SignedBy], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (25, N'00024', N'Thỉnh', N'Dương Văn', N'Dương Văn Thỉnh', NULL, N'thinhdv@vla.vn', N'0975.888.889', CAST(N'1962-05-06T00:00:00.000' AS DateTime), 1, N'81 Trần Hưng Đạo Hoàn Kiếm Hà Nội', NULL, 0, 1, 1, 1, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Staff] ([Id], [StaffCode], [FirstName], [LastName], [FullName], [UserId], [Email], [PhoneNumber], [DateOfBirth], [Gender], [Address], [Avatar], [Order], [Leader], [SeniorLeader], [SignedBy], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (26, N'00025', N'Anh', N'Trịnh Hồng', N'Trịnh Hồng Anh', NULL, N'honganh150791@gmail.com', N'0975.888.889', CAST(N'1962-05-06T00:00:00.000' AS DateTime), 1, N'81 Trần Hưng Đạo Hoàn Kiếm Hà Nội', NULL, 0, 1, 1, 1, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Staff] ([Id], [StaffCode], [FirstName], [LastName], [FullName], [UserId], [Email], [PhoneNumber], [DateOfBirth], [Gender], [Address], [Avatar], [Order], [Leader], [SeniorLeader], [SignedBy], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (27, N'00026', N'Tân', N'Trần Phúc', N'Trần Phúc Tân', NULL, N'tantp@vla.vn', N'0975.888.889', CAST(N'1962-05-06T00:00:00.000' AS DateTime), 1, N'81 Trần Hưng Đạo Hoàn Kiếm Hà Nội', NULL, 0, 1, 1, 1, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Staff] ([Id], [StaffCode], [FirstName], [LastName], [FullName], [UserId], [Email], [PhoneNumber], [DateOfBirth], [Gender], [Address], [Avatar], [Order], [Leader], [SeniorLeader], [SignedBy], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (28, N'00027', N'Độ', N'Phan Thanh', N'Phan Thanh Độ', NULL, N'phanthanhdo.cntt@gmail.com', N'0975.888.889', CAST(N'1962-05-06T00:00:00.000' AS DateTime), 1, N'81 Trần Hưng Đạo Hoàn Kiếm Hà Nội', NULL, 0, 1, 1, 1, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Staff] ([Id], [StaffCode], [FirstName], [LastName], [FullName], [UserId], [Email], [PhoneNumber], [DateOfBirth], [Gender], [Address], [Avatar], [Order], [Leader], [SeniorLeader], [SignedBy], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (29, N'00028', N'Tú', N'Phan Anh', N'Phan Anh Tú', NULL, N'phananhtu1979@gmail.com', N'0975.888.889', CAST(N'1962-05-06T00:00:00.000' AS DateTime), 1, N'81 Trần Hưng Đạo Hoàn Kiếm Hà Nội', NULL, 0, 1, 1, 1, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Staff] ([Id], [StaffCode], [FirstName], [LastName], [FullName], [UserId], [Email], [PhoneNumber], [DateOfBirth], [Gender], [Address], [Avatar], [Order], [Leader], [SeniorLeader], [SignedBy], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (30, N'00029', N'Hải', N'Chử Thanh', N'Chử Thanh Hải', NULL, N'thanhhai_hmc@yahoo.com', N'0975.888.889', CAST(N'1962-05-06T00:00:00.000' AS DateTime), 1, N'81 Trần Hưng Đạo Hoàn Kiếm Hà Nội', NULL, 0, 1, 1, 1, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Staff] ([Id], [StaffCode], [FirstName], [LastName], [FullName], [UserId], [Email], [PhoneNumber], [DateOfBirth], [Gender], [Address], [Avatar], [Order], [Leader], [SeniorLeader], [SignedBy], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (31, N'00030', N'Thanh', N'Lê Hoài', N'Lê Hoài Thanh', NULL, N'lehoaithanh@gmail.com', N'0975.888.889', CAST(N'1962-05-06T00:00:00.000' AS DateTime), 1, N'81 Trần Hưng Đạo Hoàn Kiếm Hà Nội', NULL, 0, 1, 1, 1, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Staff] ([Id], [StaffCode], [FirstName], [LastName], [FullName], [UserId], [Email], [PhoneNumber], [DateOfBirth], [Gender], [Address], [Avatar], [Order], [Leader], [SeniorLeader], [SignedBy], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (32, N'00031', N'Hưng', N'Dư Duy', N'Dư Duy Hưng', NULL, N'duyhungdu@gmail.com', N'0975.888.889', CAST(N'1962-05-06T00:00:00.000' AS DateTime), 1, N'81 Trần Hưng Đạo Hoàn Kiếm Hà Nội', NULL, 0, 1, 1, 1, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Staff] ([Id], [StaffCode], [FirstName], [LastName], [FullName], [UserId], [Email], [PhoneNumber], [DateOfBirth], [Gender], [Address], [Avatar], [Order], [Leader], [SeniorLeader], [SignedBy], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (33, N'00032', N'Trưởng', N'Phạm Hữu', N'Phạm Hữu Trưởng', NULL, N'truongphh@gmail.com', N'0975.888.889', CAST(N'1962-05-06T00:00:00.000' AS DateTime), 1, N'81 Trần Hưng Đạo Hoàn Kiếm Hà Nội', NULL, 0, 1, 1, 1, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Staff] ([Id], [StaffCode], [FirstName], [LastName], [FullName], [UserId], [Email], [PhoneNumber], [DateOfBirth], [Gender], [Address], [Avatar], [Order], [Leader], [SeniorLeader], [SignedBy], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (34, N'00033', N'Nhung', N'Hà Thị', N'Hà Thị Nhung', NULL, N'hathinhung92@gmail.com', N'0975.888.889', CAST(N'1962-05-06T00:00:00.000' AS DateTime), 1, N'81 Trần Hưng Đạo Hoàn Kiếm Hà Nội', NULL, 0, 1, 1, 1, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [organiz].[Staff] ([Id], [StaffCode], [FirstName], [LastName], [FullName], [UserId], [Email], [PhoneNumber], [DateOfBirth], [Gender], [Address], [Avatar], [Order], [Leader], [SeniorLeader], [SignedBy], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (35, N'00034', N'Hải', N'Hoàng Thị Ngọc', N'Hoàng Thị Ngọc Hải', NULL, N'hoangngochai2014@yahoo.com.vn', N'0975.888.889', CAST(N'1962-05-06T00:00:00.000' AS DateTime), 1, N'81 Trần Hưng Đạo Hoàn Kiếm Hà Nội', NULL, 0, 1, 1, 1, 1, 0, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-05-01T00:00:00.000' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
SET IDENTITY_INSERT [organiz].[Staff] OFF
SET IDENTITY_INSERT [share].[SystemConfig] ON 

INSERT [share].[SystemConfig] ([Id], [Title], [Value], [Description], [Type], [AllowClientEdit], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (2, N'MaNV', N'0001', N'mã nhân viên 2', 0, 1, 0, 0, CAST(N'2017-03-15T08:03:44.210' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-03-15T08:03:44.210' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [share].[SystemConfig] ([Id], [Title], [Value], [Description], [Type], [AllowClientEdit], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (3, N'MACV', N'00001', N'mã công việc', 0, 0, 1, 0, CAST(N'2017-01-01T00:00:00.000' AS DateTime), N'string 1', CAST(N'2017-01-01T00:00:00.000' AS DateTime), N'string 2')
INSERT [share].[SystemConfig] ([Id], [Title], [Value], [Description], [Type], [AllowClientEdit], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (1002, N'VEPH', N'Trần Thị Tâm', N'Nhà xuất bản Giáo dục Việt Nam', 0, 1, 1, 1, CAST(N'2017-03-14T09:27:47.370' AS DateTime), N'string 2', CAST(N'2017-03-14T09:27:47.370' AS DateTime), N'string 1')
INSERT [share].[SystemConfig] ([Id], [Title], [Value], [Description], [Type], [AllowClientEdit], [Active], [Deleted], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (1003, N'VEPH', N'Thông báo', N'Thông báo', 1, 0, 0, 0, CAST(N'2017-03-14T09:29:44.577' AS DateTime), N'string 2', CAST(N'2017-03-14T09:29:44.577' AS DateTime), N'string 1')
SET IDENTITY_INSERT [share].[SystemConfig] OFF
INSERT [share].[SystemConfigDepartment] ([DepartmentId], [ConfigId], [Value], [Description], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (3, 2, N'sample string 3', N'sample string 4', CAST(N'2017-03-17T09:41:29.440' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-03-17T09:41:29.440' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [share].[SystemConfigDepartment] ([DepartmentId], [ConfigId], [Value], [Description], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (3, 3, N'sample string 3', N'sample string 4', CAST(N'2017-03-17T09:41:29.440' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-03-17T09:41:29.440' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
INSERT [share].[SystemConfigDepartment] ([DepartmentId], [ConfigId], [Value], [Description], [CreatedOn], [CreatedBy], [EditedOn], [EditedBy]) VALUES (3, 1002, N'123123234 st345ring 3', N'sample string 4', CAST(N'2017-03-17T09:41:29.440' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a', CAST(N'2017-03-17T09:41:29.440' AS DateTime), N'c8df8541-be47-4a62-b217-e4da7bf89f7a')
SET ANSI_PADDING ON

GO
/****** Object:  Index [RoleNameIndex]    Script Date: 5/14/2017 9:11:49 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserId]    Script Date: 5/14/2017 9:11:49 AM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserId]    Script Date: 5/14/2017 9:11:49 AM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_RoleId]    Script Date: 5/14/2017 9:11:49 AM ******/
CREATE NONCLUSTERED INDEX [IX_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserId]    Script Date: 5/14/2017 9:11:49 AM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserRoles]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UserNameIndex]    Script Date: 5/14/2017 9:11:49 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [cate].[Country] ADD  CONSTRAINT [DF_Country_Order]  DEFAULT ((0)) FOR [Order]
GO
ALTER TABLE [cate].[Customer] ADD  CONSTRAINT [DF_Customer_Order]  DEFAULT ((0)) FOR [Order]
GO
ALTER TABLE [cate].[Customer] ADD  CONSTRAINT [DF_Customer_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [cate].[Customer] ADD  CONSTRAINT [DF_Customer_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [cate].[Customer] ADD  CONSTRAINT [DF_Customer_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [cate].[Customer] ADD  CONSTRAINT [DF_Customer_EditedOn]  DEFAULT (getdate()) FOR [EditedOn]
GO
ALTER TABLE [cate].[MeetingRoom] ADD  CONSTRAINT [DF_MeetingRoom_Splittable]  DEFAULT ((0)) FOR [Splittable]
GO
ALTER TABLE [cate].[MeetingRoom] ADD  CONSTRAINT [DF_MeetingRoom_Shareable]  DEFAULT ((1)) FOR [Shareable]
GO
ALTER TABLE [cate].[MeetingRoom] ADD  CONSTRAINT [DF_MeetingRoom_Order]  DEFAULT ((0)) FOR [Order]
GO
ALTER TABLE [cate].[MeetingRoom] ADD  CONSTRAINT [DF_MeetingRoom_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [cate].[MeetingRoom] ADD  CONSTRAINT [DF_MeetingRoom_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [cate].[MeetingRoom] ADD  CONSTRAINT [DF_MeetingRoom_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [cate].[MeetingRoom] ADD  CONSTRAINT [DF_MeetingRoom_EditedOn]  DEFAULT (getdate()) FOR [EditedOn]
GO
ALTER TABLE [cate].[Status] ADD  CONSTRAINT [DF_Status_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [cate].[Status] ADD  CONSTRAINT [DF_Status_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [cate].[Status] ADD  CONSTRAINT [DF_Status_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [cate].[Status] ADD  CONSTRAINT [DF_Status_EditedOn]  DEFAULT (getdate()) FOR [EditedOn]
GO
ALTER TABLE [cld].[Event] ADD  CONSTRAINT [DF_Event_OccurDate]  DEFAULT (getdate()) FOR [OccurDate]
GO
ALTER TABLE [cld].[Event] ADD  CONSTRAINT [DF_Event_StartTimeUnderfined]  DEFAULT ((0)) FOR [StartTimeUnderfined]
GO
ALTER TABLE [cld].[Event] ADD  CONSTRAINT [DF_Event_EndTimeUndefined]  DEFAULT ((0)) FOR [EndTimeUndefined]
GO
ALTER TABLE [cld].[Event] ADD  CONSTRAINT [DF_Event_Morning]  DEFAULT ((1)) FOR [Morning]
GO
ALTER TABLE [cld].[Event] ADD  CONSTRAINT [DF_Event_Public]  DEFAULT ((1)) FOR [Public]
GO
ALTER TABLE [cld].[Event] ADD  CONSTRAINT [DF_Event_Important]  DEFAULT ((0)) FOR [Important]
GO
ALTER TABLE [cld].[Event] ADD  CONSTRAINT [DF_Event_Accepted]  DEFAULT ((1)) FOR [Accepted]
GO
ALTER TABLE [cld].[Event] ADD  CONSTRAINT [DF_Event_Cancel]  DEFAULT ((0)) FOR [Canceled]
GO
ALTER TABLE [cld].[Event] ADD  CONSTRAINT [DF_Event_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [cld].[Event] ADD  CONSTRAINT [DF_Event_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [cld].[Event] ADD  CONSTRAINT [DF_Event_EditedOn]  DEFAULT (getdate()) FOR [EditedOn]
GO
ALTER TABLE [cld].[EventUserNotify] ADD  CONSTRAINT [DF_EventUser_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [cld].[ImportantJob] ADD  CONSTRAINT [DF_ImportantJob_Note]  DEFAULT ((0)) FOR [Note]
GO
ALTER TABLE [cld].[ImportantJob] ADD  CONSTRAINT [DF_ImportantJob_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [cld].[ImportantJob] ADD  CONSTRAINT [DF_ImportantJob_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [cld].[ImportantJob] ADD  CONSTRAINT [DF_ImportantJob_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [cld].[ImportantJob] ADD  CONSTRAINT [DF_ImportantJob_EditedOn]  DEFAULT (getdate()) FOR [EditedOn]
GO
ALTER TABLE [dbo].[AspNetGroups] ADD  CONSTRAINT [DF_AspNetGroups_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[AspNetGroups] ADD  CONSTRAINT [DF_AspNetGroups_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[AspNetGroups] ADD  CONSTRAINT [DF_AspNetGroups_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[AspNetGroups] ADD  CONSTRAINT [DF_AspNetGroups_EditedOn]  DEFAULT (getdate()) FOR [EditedOn]
GO
ALTER TABLE [dbo].[AspNetRoles] ADD  CONSTRAINT [DF_AspNetRoles_Order]  DEFAULT ((0)) FOR [Order]
GO
ALTER TABLE [dbo].[AspNetUserRoles] ADD  CONSTRAINT [DF_AspNetUserRoles_Grant]  DEFAULT ((1)) FOR [Grant]
GO
ALTER TABLE [dbo].[AspNetUsers] ADD  CONSTRAINT [DF_AspNetUsers_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[AspNetUsers] ADD  CONSTRAINT [DF_AspNetUsers_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[AspNetUsers] ADD  CONSTRAINT [DF_AspNetUsers_CreatedBy]  DEFAULT (N'c8df8541-be47-4a62-b217-e4da7bf89f7a') FOR [CreatedBy]
GO
ALTER TABLE [dbo].[AspNetUsers] ADD  CONSTRAINT [DF_AspNetUsers_EditedOn]  DEFAULT (getdate()) FOR [EditedOn]
GO
ALTER TABLE [dbo].[AspNetUsers] ADD  CONSTRAINT [DF_AspNetUsers_EditedBy]  DEFAULT (N'c8df8541-be47-4a62-b217-e4da7bf89f7a') FOR [EditedBy]
GO
ALTER TABLE [doc].[DocumentAttachment] ADD  CONSTRAINT [DF_DocumentAttachment_ReceivedDocument]  DEFAULT ((1)) FOR [ReceivedDocument]
GO
ALTER TABLE [doc].[DocumentAttachment] ADD  CONSTRAINT [DF_DocumentAttachment_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [doc].[DocumentAttachment] ADD  CONSTRAINT [DF_DocumentAttachment_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [doc].[DocumentAttachment] ADD  CONSTRAINT [DF_DocumentAttachment_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [doc].[DocumentAttachment] ADD  CONSTRAINT [DF_DocumentAttachment_EditedOn]  DEFAULT (getdate()) FOR [EditedOn]
GO
ALTER TABLE [doc].[DocumentDelivered] ADD  CONSTRAINT [DF_DeliveredDocument_SecretLevel]  DEFAULT ((0)) FOR [SecretLevel]
GO
ALTER TABLE [doc].[DocumentDelivered] ADD  CONSTRAINT [DF_DeliveredDocument_UrgencyLevels]  DEFAULT ((0)) FOR [UrgencyLevel]
GO
ALTER TABLE [doc].[DocumentDelivered] ADD  CONSTRAINT [DF_DeliveredDocument_LegalDocument]  DEFAULT ((0)) FOR [LegalDocument]
GO
ALTER TABLE [doc].[DocumentDelivered] ADD  CONSTRAINT [DF_DeliveredDocument_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [doc].[DocumentDelivered] ADD  CONSTRAINT [DF_DeliveredDocument_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [doc].[DocumentDelivered] ADD  CONSTRAINT [DF_DeliveredDocument_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [doc].[DocumentDelivered] ADD  CONSTRAINT [DF_DeliveredDocument_EditedOn]  DEFAULT (getdate()) FOR [EditedOn]
GO
ALTER TABLE [doc].[DocumentDocumentFields] ADD  CONSTRAINT [DF_DocumentDocumentFields_ReceivedDocument]  DEFAULT ((1)) FOR [ReceivedDocument]
GO
ALTER TABLE [doc].[DocumentDocumentFields] ADD  CONSTRAINT [DF_DocumentDocumentFields_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [doc].[DocumentField] ADD  CONSTRAINT [DF_DocumentField_AllowClientEdit]  DEFAULT ((1)) FOR [AllowClientEdit]
GO
ALTER TABLE [doc].[DocumentField] ADD  CONSTRAINT [DF_Doc_Field_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [doc].[DocumentField] ADD  CONSTRAINT [DF_Doc_Field_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [doc].[DocumentField] ADD  CONSTRAINT [DF_Doc_Field_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [doc].[DocumentField] ADD  CONSTRAINT [DF_Doc_Field_EditedOn]  DEFAULT (getdate()) FOR [EditedOn]
GO
ALTER TABLE [doc].[DocumentFieldDepartment] ADD  CONSTRAINT [DF_DocumentFieldDepartment_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [doc].[DocumentFieldDepartment] ADD  CONSTRAINT [DF_DocumentFieldDepartment_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [doc].[DocumentFieldDepartment] ADD  CONSTRAINT [DF_DocumentFieldDepartment_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [doc].[DocumentHistory] ADD  CONSTRAINT [DF_DocumentHistory_ReceivedDocument]  DEFAULT ((1)) FOR [ReceivedDocument]
GO
ALTER TABLE [doc].[DocumentHistory] ADD  CONSTRAINT [DF_DocumentHistory_AttempOn]  DEFAULT (getdate()) FOR [AttempOn]
GO
ALTER TABLE [doc].[DocumentOpinion] ADD  CONSTRAINT [DF_Opinion_ReceivedDocument]  DEFAULT ((1)) FOR [ReceivedDocument]
GO
ALTER TABLE [doc].[DocumentOpinion] ADD  CONSTRAINT [DF_DocumentOpinion_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [doc].[DocumentOpinion] ADD  CONSTRAINT [DF_Opinion_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [doc].[DocumentOpinion] ADD  CONSTRAINT [DF_Opinion_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [doc].[DocumentOpinion] ADD  CONSTRAINT [DF_Opinion_EditedOn]  DEFAULT (getdate()) FOR [EditedOn]
GO
ALTER TABLE [doc].[DocumentOpinionAttachment] ADD  CONSTRAINT [DF_DocumentOpinionAttachment_Type]  DEFAULT ((1)) FOR [Type]
GO
ALTER TABLE [doc].[DocumentOpinionAttachment] ADD  CONSTRAINT [DF_DocumentOpinionAttachment_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [doc].[DocumentOpinionAttachment] ADD  CONSTRAINT [DF_DocumentOpinionAttachment_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [doc].[DocumentOpinionAttachment] ADD  CONSTRAINT [DF_DocumentOpinionAttachment_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [doc].[DocumentOpinionAttachment] ADD  CONSTRAINT [DF_DocumentOpinionAttachment_EditedOn]  DEFAULT (getdate()) FOR [EditedOn]
GO
ALTER TABLE [doc].[DocumentReceived] ADD  CONSTRAINT [DF_ReceivedDocument_AddedDocumentBook]  DEFAULT ((0)) FOR [AddedDocumentBook]
GO
ALTER TABLE [doc].[DocumentReceived] ADD  CONSTRAINT [DF_Table_1_SecretLevel]  DEFAULT ((0)) FOR [SecretLevel]
GO
ALTER TABLE [doc].[DocumentReceived] ADD  CONSTRAINT [DF_Table_1_UrgencyLevels]  DEFAULT ((0)) FOR [UrgencyLevel]
GO
ALTER TABLE [doc].[DocumentReceived] ADD  CONSTRAINT [DF_ReceivedDocument_LegalDocument]  DEFAULT ((0)) FOR [LegalDocument]
GO
ALTER TABLE [doc].[DocumentReceived] ADD  CONSTRAINT [DF_ReceivedDocument_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [doc].[DocumentReceived] ADD  CONSTRAINT [DF_ReceivedDocument_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [doc].[DocumentReceived] ADD  CONSTRAINT [DF_ReceivedDocument_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [doc].[DocumentReceived] ADD  CONSTRAINT [DF_ReceivedDocument_EditedOn]  DEFAULT (getdate()) FOR [EditedOn]
GO
ALTER TABLE [doc].[DocumentRecipent] ADD  CONSTRAINT [DF_DocumentRecipent_ReceivedDocument]  DEFAULT ((1)) FOR [ReceivedDocument]
GO
ALTER TABLE [doc].[DocumentRecipent] ADD  CONSTRAINT [DF_DocumentRecipent_Forwarded]  DEFAULT ((0)) FOR [Forwarded]
GO
ALTER TABLE [doc].[DocumentRecipent] ADD  CONSTRAINT [DF_DocumentRecipent_Assigned]  DEFAULT ((0)) FOR [Assigned]
GO
ALTER TABLE [doc].[DocumentRecipent] ADD  CONSTRAINT [DF_DocumentRecipent_AddedDocumentBook]  DEFAULT ((0)) FOR [AddedDocumentBook]
GO
ALTER TABLE [doc].[DocumentRecipent] ADD  CONSTRAINT [DF_DocumentRecipent_ForSending]  DEFAULT ((0)) FOR [ForSending]
GO
ALTER TABLE [doc].[DocumentRecipent] ADD  CONSTRAINT [DF_DocumentRecipent_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [doc].[DocumentSignedBy] ADD  CONSTRAINT [DF_DocumentSigned_ReceivedDocument]  DEFAULT ((1)) FOR [ReceivedDocument]
GO
ALTER TABLE [doc].[DocumentSignedBy] ADD  CONSTRAINT [DF_DocumentSigned_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [doc].[DocumentSignedBy] ADD  CONSTRAINT [DF_DocumentSigned_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [doc].[DocumentSignedBy] ADD  CONSTRAINT [DF_DocumentSigned_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [doc].[DocumentSignedBy] ADD  CONSTRAINT [DF_DocumentSigned_EditedOn]  DEFAULT (getdate()) FOR [EditedOn]
GO
ALTER TABLE [doc].[DocumentType] ADD  CONSTRAINT [DF_Doc_Type_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [doc].[DocumentType] ADD  CONSTRAINT [DF_Doc_Type_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [doc].[DocumentType] ADD  CONSTRAINT [DF_Doc_Type_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [doc].[DocumentType] ADD  CONSTRAINT [DF_Doc_Type_EditedOn]  DEFAULT (getdate()) FOR [EditedOn]
GO
ALTER TABLE [doc].[ExternalSendReceiveDivision] ADD  CONSTRAINT [DF_ExternalSendReceiveDivision_ReceivedDocument]  DEFAULT ((1)) FOR [ReceivedDocument]
GO
ALTER TABLE [doc].[ExternalSendReceiveDivision] ADD  CONSTRAINT [DF_ExternalRecipent_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [doc].[ExternalSendReceiveDivision] ADD  CONSTRAINT [DF_ExternalRecipent_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [doc].[ExternalSendReceiveDivision] ADD  CONSTRAINT [DF_ExternalRecipent_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [doc].[ExternalSendReceiveDivision] ADD  CONSTRAINT [DF_ExternalRecipent_EditedOn]  DEFAULT (getdate()) FOR [EditedOn]
GO
ALTER TABLE [organiz].[Department] ADD  CONSTRAINT [DF_Department_Root]  DEFAULT ((0)) FOR [Root]
GO
ALTER TABLE [organiz].[Department] ADD  CONSTRAINT [DF_Department_ParentId]  DEFAULT ((0)) FOR [ParentId]
GO
ALTER TABLE [organiz].[Department] ADD  CONSTRAINT [DF_Department_Order]  DEFAULT ((0)) FOR [Order]
GO
ALTER TABLE [organiz].[Department] ADD  CONSTRAINT [DF_Department_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [organiz].[Department] ADD  CONSTRAINT [DF_Department_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [organiz].[Department] ADD  CONSTRAINT [DF_Department_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [organiz].[Department] ADD  CONSTRAINT [DF_Department_EditedOn]  DEFAULT (getdate()) FOR [EditedOn]
GO
ALTER TABLE [organiz].[DepartmentStaffs] ADD  CONSTRAINT [DF_DepartmentStaffs_MainDepartment]  DEFAULT ((0)) FOR [MainDepartment]
GO
ALTER TABLE [organiz].[DepartmentStaffs] ADD  CONSTRAINT [DF_DepartmentStaffs_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [organiz].[DepartmentStaffs] ADD  CONSTRAINT [DF_DepartmentStaffs_EditedOn]  DEFAULT (getdate()) FOR [EditedOn]
GO
ALTER TABLE [organiz].[Staff] ADD  CONSTRAINT [DF_Staff_Order]  DEFAULT ((0)) FOR [Order]
GO
ALTER TABLE [organiz].[Staff] ADD  CONSTRAINT [DF_Staff_Leader]  DEFAULT ((0)) FOR [Leader]
GO
ALTER TABLE [organiz].[Staff] ADD  CONSTRAINT [DF_Staff_SeniorLeader]  DEFAULT ((0)) FOR [SeniorLeader]
GO
ALTER TABLE [organiz].[Staff] ADD  CONSTRAINT [DF_Staff_SignedBy]  DEFAULT ((0)) FOR [SignedBy]
GO
ALTER TABLE [organiz].[Staff] ADD  CONSTRAINT [DF_Staff_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [organiz].[Staff] ADD  CONSTRAINT [DF_Staff_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [organiz].[Staff] ADD  CONSTRAINT [DF_Staff_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [organiz].[Staff] ADD  CONSTRAINT [DF_Staff_EditedOn]  DEFAULT (getdate()) FOR [EditedOn]
GO
ALTER TABLE [share].[ApplicationLogging] ADD  CONSTRAINT [DF_share.ApplicationLoging_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [share].[Function] ADD  CONSTRAINT [DF_Function_ParentId]  DEFAULT ((0)) FOR [ParentId]
GO
ALTER TABLE [share].[Function] ADD  CONSTRAINT [DF_Function_Target]  DEFAULT (N'_self') FOR [Target]
GO
ALTER TABLE [share].[Function] ADD  CONSTRAINT [DF_Function_Order]  DEFAULT ((0)) FOR [Order]
GO
ALTER TABLE [share].[Function] ADD  CONSTRAINT [DF_Function_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [share].[Function] ADD  CONSTRAINT [DF_Function_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [share].[Function] ADD  CONSTRAINT [DF_Function_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [share].[Function] ADD  CONSTRAINT [DF_Function_EditedOn]  DEFAULT (getdate()) FOR [EditedOn]
GO
ALTER TABLE [share].[SystemConfig] ADD  CONSTRAINT [DF_SystemConfig_Type]  DEFAULT ((0)) FOR [Type]
GO
ALTER TABLE [share].[SystemConfig] ADD  CONSTRAINT [DF_SystemConfig_AllowClientEdit]  DEFAULT ((1)) FOR [AllowClientEdit]
GO
ALTER TABLE [share].[SystemConfig] ADD  CONSTRAINT [DF_SystemConfig_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [share].[SystemConfig] ADD  CONSTRAINT [DF_SystemConfig_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [share].[SystemConfig] ADD  CONSTRAINT [DF_SystemConfig_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [share].[SystemConfig] ADD  CONSTRAINT [DF_SystemConfig_EditedOn]  DEFAULT (getdate()) FOR [EditedOn]
GO
ALTER TABLE [share].[SystemConfigDepartment] ADD  CONSTRAINT [DF_SystemConfigDepartment_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [share].[SystemConfigDepartment] ADD  CONSTRAINT [DF_SystemConfigDepartment_EditedOn]  DEFAULT (getdate()) FOR [EditedOn]
GO
ALTER TABLE [task].[Project] ADD  CONSTRAINT [DF_Project_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [task].[Project] ADD  CONSTRAINT [DF_Project_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [task].[Project] ADD  CONSTRAINT [DF_Project_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [task].[Project] ADD  CONSTRAINT [DF_Project_EditedOn]  DEFAULT (getdate()) FOR [EditedOn]
GO
ALTER TABLE [task].[Task] ADD  CONSTRAINT [DF_Task_Order]  DEFAULT ((0)) FOR [Order]
GO
ALTER TABLE [task].[Task] ADD  CONSTRAINT [DF_Task_Priority]  DEFAULT ((1)) FOR [Priority]
GO
ALTER TABLE [task].[Task] ADD  CONSTRAINT [DF_Task_DueDate]  DEFAULT (getdate()) FOR [DueDate]
GO
ALTER TABLE [task].[Task] ADD  CONSTRAINT [DF_Task_Rating]  DEFAULT ((1)) FOR [Rating]
GO
ALTER TABLE [task].[Task] ADD  CONSTRAINT [DF_Task_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [task].[Task] ADD  CONSTRAINT [DF_Task_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [task].[Task] ADD  CONSTRAINT [DF_Task_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [task].[Task] ADD  CONSTRAINT [DF_Task_EditedOn]  DEFAULT (getdate()) FOR [EditedOn]
GO
ALTER TABLE [task].[TaskAssignee] ADD  CONSTRAINT [DF_Table_1_Handler]  DEFAULT ((0)) FOR [Assignee]
GO
ALTER TABLE [task].[TaskAssignee] ADD  CONSTRAINT [DF_TaskAssignee_Coprocessor]  DEFAULT ((0)) FOR [Coprocessor]
GO
ALTER TABLE [task].[TaskAssignee] ADD  CONSTRAINT [DF_TaskAssignee_Order]  DEFAULT ((0)) FOR [Order]
GO
ALTER TABLE [task].[TaskAssignee] ADD  CONSTRAINT [DF_TaskAssignee_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [task].[TaskAttachment] ADD  CONSTRAINT [DF_TaskAttachment_Type]  DEFAULT ((1)) FOR [Type]
GO
ALTER TABLE [task].[TaskAttachment] ADD  CONSTRAINT [DF_TaskAttachment_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [task].[TaskAttachment] ADD  CONSTRAINT [DF_TaskAttachment_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [task].[TaskAttachment] ADD  CONSTRAINT [DF_TaskAttachment_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [task].[TaskAttachment] ADD  CONSTRAINT [DF_TaskAttachment_EditedOn]  DEFAULT (getdate()) FOR [EditedOn]
GO
ALTER TABLE [task].[TaskDocuments] ADD  CONSTRAINT [DF_TaskDocuments_ReceivedDocument]  DEFAULT ((1)) FOR [ReceivedDocument]
GO
ALTER TABLE [task].[TaskDocuments] ADD  CONSTRAINT [DF_TaskDocuments_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [task].[TaskOpinion] ADD  CONSTRAINT [DF_TaskOpinion_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [task].[TaskOpinion] ADD  CONSTRAINT [DF_TaskOpinion_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [task].[TaskOpinion] ADD  CONSTRAINT [DF_TaskOpinion_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [task].[TaskOpinion] ADD  CONSTRAINT [DF_TaskOpinion_EditedOn]  DEFAULT (getdate()) FOR [EditedOn]
GO
ALTER TABLE [task].[TaskType] ADD  CONSTRAINT [DF_TaskType_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [task].[TaskType] ADD  CONSTRAINT [DF_TaskType_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [task].[TaskType] ADD  CONSTRAINT [DF_TaskType_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [task].[TaskType] ADD  CONSTRAINT [DF_TaskType_EditedOn]  DEFAULT (getdate()) FOR [EditedOn]
GO
ALTER TABLE [cld].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_Department] FOREIGN KEY([DepartmentId])
REFERENCES [organiz].[Department] ([Id])
GO
ALTER TABLE [cld].[Event] CHECK CONSTRAINT [FK_Event_Department]
GO
ALTER TABLE [cld].[EventUserNotify]  WITH CHECK ADD  CONSTRAINT [FK_EventUser_Event] FOREIGN KEY([EventId])
REFERENCES [cld].[Event] ([Id])
GO
ALTER TABLE [cld].[EventUserNotify] CHECK CONSTRAINT [FK_EventUser_Event]
GO
ALTER TABLE [cld].[ImportantJob]  WITH CHECK ADD  CONSTRAINT [FK_ImportantJob_Department] FOREIGN KEY([DepartmentId])
REFERENCES [organiz].[Department] ([Id])
GO
ALTER TABLE [cld].[ImportantJob] CHECK CONSTRAINT [FK_ImportantJob_Department]
GO
ALTER TABLE [dbo].[AspNetGroupRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetGroupRoles_AspNetGroups] FOREIGN KEY([GroupId])
REFERENCES [dbo].[AspNetGroups] ([Id])
GO
ALTER TABLE [dbo].[AspNetGroupRoles] CHECK CONSTRAINT [FK_AspNetGroupRoles_AspNetGroups]
GO
ALTER TABLE [dbo].[AspNetGroupRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetGroupRoles_AspNetRoles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
GO
ALTER TABLE [dbo].[AspNetGroupRoles] CHECK CONSTRAINT [FK_AspNetGroupRoles_AspNetRoles]
GO
ALTER TABLE [dbo].[AspNetGroupUsers]  WITH CHECK ADD  CONSTRAINT [FK_AspNetGroupUsers_AspNetGroups] FOREIGN KEY([GroupId])
REFERENCES [dbo].[AspNetGroups] ([Id])
GO
ALTER TABLE [dbo].[AspNetGroupUsers] CHECK CONSTRAINT [FK_AspNetGroupUsers_AspNetGroups]
GO
ALTER TABLE [dbo].[AspNetGroupUsers]  WITH CHECK ADD  CONSTRAINT [FK_AspNetGroupUsers_AspNetUsers] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[AspNetGroupUsers] CHECK CONSTRAINT [FK_AspNetGroupUsers_AspNetUsers]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [doc].[DocumentDelivered]  WITH CHECK ADD  CONSTRAINT [FK_DeliveredDocument_Department] FOREIGN KEY([DepartmentId])
REFERENCES [organiz].[Department] ([Id])
GO
ALTER TABLE [doc].[DocumentDelivered] CHECK CONSTRAINT [FK_DeliveredDocument_Department]
GO
ALTER TABLE [doc].[DocumentDelivered]  WITH CHECK ADD  CONSTRAINT [FK_DeliveredDocument_DocumentType] FOREIGN KEY([DocumentTypeId])
REFERENCES [doc].[DocumentType] ([Id])
GO
ALTER TABLE [doc].[DocumentDelivered] CHECK CONSTRAINT [FK_DeliveredDocument_DocumentType]
GO
ALTER TABLE [doc].[DocumentFieldDepartment]  WITH CHECK ADD  CONSTRAINT [FK_DocumentFieldDepartment_Department] FOREIGN KEY([DepartmentId])
REFERENCES [organiz].[Department] ([Id])
GO
ALTER TABLE [doc].[DocumentFieldDepartment] CHECK CONSTRAINT [FK_DocumentFieldDepartment_Department]
GO
ALTER TABLE [doc].[DocumentFieldDepartment]  WITH CHECK ADD  CONSTRAINT [FK_DocumentFieldDepartment_DocumentField] FOREIGN KEY([FieldId])
REFERENCES [doc].[DocumentField] ([Id])
GO
ALTER TABLE [doc].[DocumentFieldDepartment] CHECK CONSTRAINT [FK_DocumentFieldDepartment_DocumentField]
GO
ALTER TABLE [doc].[DocumentOpinionAttachment]  WITH CHECK ADD  CONSTRAINT [FK_DocumentOpinionAttachment_DocumentOpinion] FOREIGN KEY([OpinionId])
REFERENCES [doc].[DocumentOpinion] ([Id])
GO
ALTER TABLE [doc].[DocumentOpinionAttachment] CHECK CONSTRAINT [FK_DocumentOpinionAttachment_DocumentOpinion]
GO
ALTER TABLE [doc].[DocumentReceived]  WITH CHECK ADD  CONSTRAINT [FK_ReceivedDocument_Department] FOREIGN KEY([DepartmentId])
REFERENCES [organiz].[Department] ([Id])
GO
ALTER TABLE [doc].[DocumentReceived] CHECK CONSTRAINT [FK_ReceivedDocument_Department]
GO
ALTER TABLE [doc].[DocumentReceived]  WITH CHECK ADD  CONSTRAINT [FK_ReceivedDocument_DocumentType] FOREIGN KEY([DocumentTypeId])
REFERENCES [doc].[DocumentType] ([Id])
GO
ALTER TABLE [doc].[DocumentReceived] CHECK CONSTRAINT [FK_ReceivedDocument_DocumentType]
GO
ALTER TABLE [organiz].[DepartmentStaffs]  WITH CHECK ADD  CONSTRAINT [FK_DepartmentStaffs_Department] FOREIGN KEY([DepartmentId])
REFERENCES [organiz].[Department] ([Id])
GO
ALTER TABLE [organiz].[DepartmentStaffs] CHECK CONSTRAINT [FK_DepartmentStaffs_Department]
GO
ALTER TABLE [organiz].[DepartmentStaffs]  WITH CHECK ADD  CONSTRAINT [FK_DepartmentStaffs_Staff] FOREIGN KEY([StaffId])
REFERENCES [organiz].[Staff] ([Id])
GO
ALTER TABLE [organiz].[DepartmentStaffs] CHECK CONSTRAINT [FK_DepartmentStaffs_Staff]
GO
ALTER TABLE [share].[RoleFunction]  WITH CHECK ADD  CONSTRAINT [FK_RoleFunction_AspNetRoles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
GO
ALTER TABLE [share].[RoleFunction] CHECK CONSTRAINT [FK_RoleFunction_AspNetRoles]
GO
ALTER TABLE [share].[RoleFunction]  WITH CHECK ADD  CONSTRAINT [FK_RoleFunction_Function] FOREIGN KEY([FunctionId])
REFERENCES [share].[Function] ([Id])
GO
ALTER TABLE [share].[RoleFunction] CHECK CONSTRAINT [FK_RoleFunction_Function]
GO
ALTER TABLE [share].[SystemConfigDepartment]  WITH CHECK ADD  CONSTRAINT [FK_SystemConfigDepartment_Department] FOREIGN KEY([DepartmentId])
REFERENCES [organiz].[Department] ([Id])
GO
ALTER TABLE [share].[SystemConfigDepartment] CHECK CONSTRAINT [FK_SystemConfigDepartment_Department]
GO
ALTER TABLE [share].[SystemConfigDepartment]  WITH CHECK ADD  CONSTRAINT [FK_SystemConfigDepartment_SystemConfig] FOREIGN KEY([ConfigId])
REFERENCES [share].[SystemConfig] ([Id])
GO
ALTER TABLE [share].[SystemConfigDepartment] CHECK CONSTRAINT [FK_SystemConfigDepartment_SystemConfig]
GO
ALTER TABLE [task].[Task]  WITH CHECK ADD  CONSTRAINT [FK_Task_Department] FOREIGN KEY([DepartmentId])
REFERENCES [organiz].[Department] ([Id])
GO
ALTER TABLE [task].[Task] CHECK CONSTRAINT [FK_Task_Department]
GO
ALTER TABLE [task].[Task]  WITH CHECK ADD  CONSTRAINT [FK_Task_Project] FOREIGN KEY([ProjectId])
REFERENCES [task].[Project] ([Id])
GO
ALTER TABLE [task].[Task] CHECK CONSTRAINT [FK_Task_Project]
GO
ALTER TABLE [task].[Task]  WITH CHECK ADD  CONSTRAINT [FK_Task_TaskType] FOREIGN KEY([TaskTypeId])
REFERENCES [task].[TaskType] ([Id])
GO
ALTER TABLE [task].[Task] CHECK CONSTRAINT [FK_Task_TaskType]
GO
ALTER TABLE [task].[TaskAssignee]  WITH CHECK ADD  CONSTRAINT [FK_TaskAssignee_Task] FOREIGN KEY([TaskId])
REFERENCES [task].[Task] ([Id])
GO
ALTER TABLE [task].[TaskAssignee] CHECK CONSTRAINT [FK_TaskAssignee_Task]
GO
ALTER TABLE [task].[TaskDocuments]  WITH CHECK ADD  CONSTRAINT [FK_TaskDocuments_Task] FOREIGN KEY([TaskId])
REFERENCES [task].[Task] ([Id])
GO
ALTER TABLE [task].[TaskDocuments] CHECK CONSTRAINT [FK_TaskDocuments_Task]
GO
/****** Object:  StoredProcedure [cate].[SPGetCustomer]    Script Date: 5/14/2017 9:11:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--- exec cate.SPGetCustomer 'g',0,10,0
CREATE PROCEDURE [cate].[SPGetCustomer]
	@keyword NVARCHAR(500),
	@start INT,
	@limit INT,
	@total INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	--- Count records ---
	
	SET @total = (
	        SELECT COUNT(1)
	        FROM   cate.Customer s
	        WHERE  (
	                   @keyword = ''
	                   OR s.Code LIKE N'%' + @keyword + '%'
	                   OR s.Title LIKE N'%' + @keyword + '%'
	                   OR s.ShortTitle LIKE N'%' + @keyword + '%'
	                   OR s.[Address] LIKE N'%' + @keyword + '%'
	                   OR s.PhoneNumber LIKE N'%' + @keyword + '%'
	               )
	               AND s.Deleted = 0
	    );
	
	SELECT s.*
	FROM   cate.Customer s
	WHERE  (
	           @keyword = ''
	           OR s.Code LIKE N'%' + @keyword + '%'
	           OR s.Title LIKE N'%' + @keyword + '%'
	           OR s.ShortTitle LIKE N'%' + @keyword + '%'
	           OR s.[Address] LIKE N'%' + @keyword + '%'
	           OR s.PhoneNumber LIKE N'%' + @keyword + '%'
	       )
	       AND s.Deleted = 0
	ORDER BY
	       s.[Order]
	       OFFSET @start ROWS
	FETCH NEXT @limit ROWS ONLY;
END

GO
/****** Object:  StoredProcedure [cate].[SPGetMeetingRoom]    Script Date: 5/14/2017 9:11:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--- exec cate.SPGetMeetingRoom '',null,0,10,0
CREATE PROCEDURE [cate].[SPGetMeetingRoom]
	@keyword NVARCHAR(500),
	@departmentId NVARCHAR(500),
	@start INT,
	@limit INT,
	@total INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	--- Count records ---
	if NULLIF(@departmentId, '') IS NULL
		Begin
			SET @total = (
					SELECT COUNT(1)
					FROM   cate.MeetingRoom m
					WHERE  (
							   @keyword = ''
							   OR m.Code LIKE N'%' + @keyword + '%'
							   OR m.Title LIKE N'%' + @keyword + '%'
						   )
					AND m.Deleted = 0
				);
		end
	else
		Begin
			SET @total = (
				SELECT COUNT(1)
				FROM   cate.MeetingRoom m
				WHERE  (
						   @keyword = ''
						   OR m.Code LIKE N'%' + @keyword + '%'
						   OR m.Title LIKE N'%' + @keyword + '%'
					   )
				AND m.Deleted = 0 and (m.DepartmentId in (select value from dbo.fn_Split(@departmentId,',')))
			);
		End
		--- Fetching data
	if NULLIF(@departmentId, '') IS NULL
		BEGIN
			SELECT m.*
			FROM   cate.MeetingRoom m
			WHERE  (
						@keyword = ''
						OR m.Code LIKE N'%' + @keyword + '%'
						OR m.Title LIKE N'%' + @keyword + '%'
				   )
				  AND m.Deleted = 0
			ORDER BY
				   m.[Order]
				   OFFSET @start ROWS
			FETCH NEXT @limit ROWS ONLY;
		END
	else
		BEGIN
			SELECT m.*
			FROM   cate.MeetingRoom m
			 WHERE  (
							   @keyword = ''
							   OR m.Code LIKE N'%' + @keyword + '%'
							   OR m.Title LIKE N'%' + @keyword + '%'
						   )
					AND m.Deleted = 0 and (m.DepartmentId in (select value from dbo.fn_Split(@departmentId,',')))
			ORDER BY
				   m.[Order]
				   OFFSET @start ROWS
			FETCH NEXT @limit ROWS ONLY;
		END
	SET NOCOUNT OFF;
END;
GO
/****** Object:  StoredProcedure [doc].[SPGetDocumentSignedBy]    Script Date: 5/14/2017 9:11:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--- exec doc.SPGetDocumentSignedBy '',1,0,10,0
CREATE PROCEDURE [doc].[SPGetDocumentSignedBy]
	@keyword NVARCHAR(500),
	@receivedDocument bit = null,
	@start INT,
	@limit INT,
	@total INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	--- Count records ---
	if @receivedDocument is null
	Begin
	SET @total = (
	        SELECT COUNT(1)
	        FROM   doc.DocumentSignedBy s
	        WHERE  (
	                   @keyword = ''
	                   OR s.Fullname LIKE N'%' + @keyword + '%'
	                   OR s.Position LIKE N'%' + @keyword + '%'
	               )
			AND s.Deleted = 0 And s.Active = 1
	    );
		end
		else
		Begin
		SET @total = (
	        SELECT COUNT(1)
	        FROM   doc.DocumentSignedBy s
	        WHERE  (
	                   @keyword = ''
	                   OR s.Fullname LIKE N'%' + @keyword + '%'
	                   OR s.Position LIKE N'%' + @keyword + '%'
	               )
			AND s.Deleted = 0 And s.Active = 1 and s.ReceivedDocument=@receivedDocument
	    );
		End
		--- Fetching data
	if @receivedDocument is null
	BEGIN
	SELECT s.*
	FROM   doc.DocumentSignedBy s
	WHERE  (
	           @keyword = ''
	           OR s.FullName LIKE N'%' + @keyword + '%'
	           OR s.Position LIKE N'%' + @keyword + '%'
	       )
	       AND s.Deleted = 0  And s.Active = 1
	ORDER BY
	       s.FullName


	       OFFSET @start ROWS
	FETCH NEXT @limit ROWS ONLY;
	END
	ELSE
	BEGIN
	SELECT s.*
	FROM   doc.DocumentSignedBy s
	WHERE  (
	           @keyword = ''
	           OR s.FullName LIKE N'%' + @keyword + '%'
	           OR s.Position LIKE N'%' + @keyword + '%'
	       )
	       AND s.Deleted = 0  And s.Active = 1 And s.ReceivedDocument=@receivedDocument
	ORDER BY
	       s.FullName


	       OFFSET @start ROWS
	FETCH NEXT @limit ROWS ONLY;
	END
	
	SET NOCOUNT OFF;
END;
GO
/****** Object:  StoredProcedure [doc].[SPGetDocumentType]    Script Date: 5/14/2017 9:11:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [doc].[SPGetDocumentType]
	@keyword NVARCHAR(500),
	@start INT,
	@limit INT,
	@total INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	--- Ð?m s? b?n ghi ---
	SET @total = (
	        SELECT COUNT(1)
	        FROM   doc.DocumentType t
	        WHERE  (
	                   @keyword = ''
	                   OR t.Code LIKE N'%' + @keyword + '%'
	                   OR t.Title LIKE N'%' + @keyword + '%'
	               )
			AND t.Deleted = 0
	    );
	---- L?y Data ---
	SELECT t.*
	FROM   doc.DocumentType t
	WHERE  (
	           @keyword = ''
	           OR t.Code LIKE N'%' + @keyword + '%'
	           OR t.Title LIKE N'%' + @keyword + '%'
	       )
	       AND t.Deleted = 0
	ORDER BY
	       t.CreatedOn desc
	       OFFSET @start ROWS
	
	FETCH NEXT @limit ROWS ONLY;
	SET NOCOUNT OFF;
END;

-- DECLARE @count int;
--EXECUTE SPGetDocField
--    'ch',0,100, @Total = @count OUTPUT;

--    PRINT 'TotalRow is: ' + 
--    convert(varchar(10),@count);
--GO
GO
/****** Object:  StoredProcedure [share].[SPGetConfig]    Script Date: 5/14/2017 9:11:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [share].[SPGetConfig]
	@keyword NVARCHAR(500),
	@start INT,
	@limit INT,
	@total INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	--- Ð?m s? b?n ghi ---
	SET @total = (
	        SELECT COUNT(1)
	        FROM  share.SystemConfig t
	        WHERE  (
	                   @keyword = ''
	                   OR t.Title LIKE N'%' + @keyword + '%'
	                   OR t.[Value] LIKE N'%' + @keyword + '%'
					   OR t.[Description] LIKE N'%' + @keyword + '%'
	               )
			AND t.Deleted = 0
	    );
	---- L?y Data ---
	SELECT t.*
	FROM   share.SystemConfig t
	WHERE  (
	           @keyword = ''
	          OR t.Title LIKE N'%' + @keyword + '%'
	                   OR t.[Value] LIKE N'%' + @keyword + '%'
					   OR t.[Description] LIKE N'%' + @keyword + '%'
	       )
	       AND t.Deleted = 0
	ORDER BY
	       t.CreatedOn desc
	       OFFSET @start ROWS
	
	FETCH NEXT @limit ROWS ONLY;
	SET NOCOUNT OFF;
END;

-- DECLARE @count int;
--EXECUTE SPGetDocField
--    'ch',0,100, @Total = @count OUTPUT;

--    PRINT 'TotalRow is: ' + 
--    convert(varchar(10),@count);
--GO
GO
/****** Object:  StoredProcedure [share].[SPGetSystemConfigDepartment]    Script Date: 5/14/2017 9:11:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--exec [share].[SPGetSystemConfigDepartment] '',3,0,10,0
CREATE PROCEDURE [share].[SPGetSystemConfigDepartment]
	@keyword NVARCHAR(500),
	@departmentID int,
	@start INT,
	@limit INT,
	@total INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	--- Ð?m s? b?n ghi ---
	SET @total = (
	        SELECT COUNT(1)
	        FROM share.SystemConfig t left join  share.SystemConfigDepartment scd on t.id=scd.ConfigId
	        WHERE  (
	                   @keyword = ''
	                   OR t.Title LIKE N'%' + @keyword + '%'
	                   OR t.[Value] LIKE N'%' + @keyword + '%'
					   OR t.[Description] LIKE N'%' + @keyword + '%'
	               )
			AND t.Deleted = 0
	    );
	---- L?y Data ---
	SELECT t.Id,t.Title,t.Active,t.[Type],t.AllowClientEdit,scd.[Value],scd.[Description]
	FROM   share.SystemConfig t left join  share.SystemConfigDepartment scd on t.id=scd.ConfigId
	WHERE  (
	           @keyword = ''
	          OR t.Title LIKE N'%' + @keyword + '%'
	                   OR t.[Value] LIKE N'%' + @keyword + '%'
					   OR t.[Description] LIKE N'%' + @keyword + '%'
	       )
	       AND t.Deleted = 0
		   and (scd.DepartmentId = @departmentID or @departmentID = 0 or @departmentID is null or scd.DepartmentId is null)
	ORDER BY
	       t.CreatedOn desc
	       OFFSET @start ROWS

	
	FETCH NEXT @limit ROWS ONLY;
	SET NOCOUNT OFF;
END;

-- DECLARE @count int;
--EXECUTE SPGetDocField
--    'ch',0,100, @Total = @count OUTPUT;

--    PRINT 'TotalRow is: ' + 
--    convert(varchar(10),@count);
--GO
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Báo trước bao nhiêu phút' , @level0type=N'SCHEMA',@level0name=N'cld', @level1type=N'TABLE',@level1name=N'Event', @level2type=N'COLUMN',@level2name=N'NotificationTimeSpan'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0: Thường, 1: Mật, 2: Tối mật, 3: Tuyệt mật' , @level0type=N'SCHEMA',@level0name=N'doc', @level1type=N'TABLE',@level1name=N'DocumentDelivered', @level2type=N'COLUMN',@level2name=N'SecretLevel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0: Thường, 1: Khẩn, 2: Thượng khẩn, 3: Hỏa tốc' , @level0type=N'SCHEMA',@level0name=N'doc', @level1type=N'TABLE',@level1name=N'DocumentDelivered', @level2type=N'COLUMN',@level2name=N'UrgencyLevel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1: Task, 2: DocumentOpinion' , @level0type=N'SCHEMA',@level0name=N'doc', @level1type=N'TABLE',@level1name=N'DocumentOpinionAttachment', @level2type=N'COLUMN',@level2name=N'Type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0: Thường, 1: Mật, 2: Tối mật, 3: Tuyệt mật' , @level0type=N'SCHEMA',@level0name=N'doc', @level1type=N'TABLE',@level1name=N'DocumentReceived', @level2type=N'COLUMN',@level2name=N'SecretLevel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0: Thường, 1: Khẩn, 2: Thượng khẩn, 3: Hỏa tốc' , @level0type=N'SCHEMA',@level0name=N'doc', @level1type=N'TABLE',@level1name=N'DocumentReceived', @level2type=N'COLUMN',@level2name=N'UrgencyLevel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ERROR,WARNING,INFO,EVENT' , @level0type=N'SCHEMA',@level0name=N'share', @level1type=N'TABLE',@level1name=N'ApplicationLogging', @level2type=N'COLUMN',@level2name=N'Type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0: Text, 1: Password' , @level0type=N'SCHEMA',@level0name=N'share', @level1type=N'TABLE',@level1name=N'SystemConfig', @level2type=N'COLUMN',@level2name=N'Type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1: thường, 2: ưu tiên, 3: ưu tiên cao' , @level0type=N'SCHEMA',@level0name=N'task', @level1type=N'TABLE',@level1name=N'Task', @level2type=N'COLUMN',@level2name=N'Priority'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Đơn vị tính: Phút' , @level0type=N'SCHEMA',@level0name=N'task', @level1type=N'TABLE',@level1name=N'Task', @level2type=N'COLUMN',@level2name=N'Estimated'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Đơn vị tính: phút' , @level0type=N'SCHEMA',@level0name=N'task', @level1type=N'TABLE',@level1name=N'Task', @level2type=N'COLUMN',@level2name=N'TimeSpent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'-1: Không đạt yêu cầu, 0: Trung bình, 1: Tốt, 2: Rất tốt' , @level0type=N'SCHEMA',@level0name=N'task', @level1type=N'TABLE',@level1name=N'Task', @level2type=N'COLUMN',@level2name=N'Rating'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1: Task, 2: TaskOpinion' , @level0type=N'SCHEMA',@level0name=N'task', @level1type=N'TABLE',@level1name=N'TaskAttachment', @level2type=N'COLUMN',@level2name=N'Type'
GO
USE [master]
GO
ALTER DATABASE [VOffice] SET  READ_WRITE 
GO
