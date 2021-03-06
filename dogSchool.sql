USE [master]
GO
/****** Object:  Database [DogSchool]    Script Date: 2020-02-07 19:12:51 ******/
CREATE DATABASE [DogSchool]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DogSchool', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\DogSchool.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DogSchool_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\DogSchool_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [DogSchool] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DogSchool].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DogSchool] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DogSchool] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DogSchool] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DogSchool] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DogSchool] SET ARITHABORT OFF 
GO
ALTER DATABASE [DogSchool] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [DogSchool] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DogSchool] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DogSchool] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DogSchool] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DogSchool] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DogSchool] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DogSchool] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DogSchool] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DogSchool] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DogSchool] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DogSchool] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DogSchool] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DogSchool] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DogSchool] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DogSchool] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DogSchool] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DogSchool] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DogSchool] SET  MULTI_USER 
GO
ALTER DATABASE [DogSchool] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DogSchool] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DogSchool] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DogSchool] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DogSchool] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DogSchool] SET QUERY_STORE = OFF
GO
USE [DogSchool]
GO
/****** Object:  Table [dbo].[Dog]    Script Date: 2020-02-07 19:12:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dog](
	[dogId] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[breedName] [nvarchar](50) NOT NULL,
	[age] [int] NOT NULL,
	[notes] [nvarchar](max) NULL,
	[customerID] [int] NOT NULL,
 CONSTRAINT [PK__dogs__3214EC07A93E89F3] PRIMARY KEY CLUSTERED 
(
	[dogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Course]    Script Date: 2020-02-07 19:12:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[courseID] [int] IDENTITY(1,1) NOT NULL,
	[CourseName] [nvarchar](50) NOT NULL,
	[startDate] [date] NULL,
	[endDate] [date] NULL,
	[location] [nvarchar](50) NULL,
	[slots] [int] NULL,
 CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
	[courseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 2020-02-07 19:12:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[customerID] [int] IDENTITY(1,1) NOT NULL,
	[fName] [nvarchar](50) NOT NULL,
	[lName] [nvarchar](50) NOT NULL,
	[email] [nvarchar](50) NOT NULL,
	[phone] [varchar](10) NOT NULL,
	[notes] [nvarchar](max) NULL,
	[courseID] [int] NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[customerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwCourseParticpants]    Script Date: 2020-02-07 19:12:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwCourseParticpants]
AS
SELECT dbo.Course.CourseName AS Kursensnamn, dbo.Course.startDate AS Startdatum, dbo.Course.endDate AS Slutdatum, dbo.Course.location AS Plats, dbo.Customer.fName AS Förnamn, dbo.Customer.lName AS Efternamn, dbo.Dog.breedName AS Ras, dbo.Dog.age AS Ålder, dbo.Dog.name AS [Hundens namn], dbo.Customer.email, dbo.Customer.phone, 
         dbo.Dog.notes AS [Dogs Notes], dbo.Customer.notes AS CustomerNotes
FROM  dbo.Course INNER JOIN
         dbo.Customer ON dbo.Course.courseID = dbo.Customer.courseID INNER JOIN
         dbo.Dog ON dbo.Customer.customerID = dbo.Dog.customerID
GO
/****** Object:  View [dbo].[vwCustomerCourse]    Script Date: 2020-02-07 19:12:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwCustomerCourse]
AS
SELECT dbo.Customer.customerID, dbo.Course.CourseName, dbo.Course.startDate, dbo.Course.endDate, dbo.Course.location, dbo.Course.slots, dbo.Customer.fName AS [First Name], dbo.Customer.lName AS [Last Name], dbo.Customer.email, dbo.Customer.phone, dbo.Customer.notes
FROM  dbo.Course INNER JOIN
         dbo.Customer ON dbo.Course.courseID = dbo.Customer.courseID
GO
/****** Object:  Table [dbo].[CourseAudit]    Script Date: 2020-02-07 19:12:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseAudit](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AuditData] [nvarchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CourseInstructor]    Script Date: 2020-02-07 19:12:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseInstructor](
	[courseID] [int] NOT NULL,
	[instructorID] [int] NOT NULL,
 CONSTRAINT [PK_CourseInstructor] PRIMARY KEY CLUSTERED 
(
	[courseID] ASC,
	[instructorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CourseSales]    Script Date: 2020-02-07 19:12:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseSales](
	[courseSalesId] [int] IDENTITY(1,1) NOT NULL,
	[courseID] [int] NULL,
	[dateOfBooking] [date] NULL,
 CONSTRAINT [PK__CourseSa__E3075412893CABE7] PRIMARY KEY CLUSTERED 
(
	[courseSalesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Instructor]    Script Date: 2020-02-07 19:12:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Instructor](
	[instructorID] [int] IDENTITY(1,1) NOT NULL,
	[fName] [nvarchar](50) NOT NULL,
	[lName] [nvarchar](50) NOT NULL,
	[email] [nvarchar](50) NOT NULL,
	[phone] [varchar](10) NOT NULL,
	[notes] [nvarchar](max) NULL,
 CONSTRAINT [PK_Instructor] PRIMARY KEY CLUSTERED 
(
	[instructorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Customer] ADD  CONSTRAINT [DF__Customer__email__324172E1]  DEFAULT ('0') FOR [email]
GO
ALTER TABLE [dbo].[Customer] ADD  CONSTRAINT [DF__Customer__phone__370627FE]  DEFAULT ('0') FOR [phone]
GO
ALTER TABLE [dbo].[Instructor] ADD  DEFAULT ('0') FOR [email]
GO
ALTER TABLE [dbo].[Instructor] ADD  DEFAULT ('0') FOR [phone]
GO
ALTER TABLE [dbo].[CourseInstructor]  WITH CHECK ADD  CONSTRAINT [FK_CourseInstructor_Course] FOREIGN KEY([courseID])
REFERENCES [dbo].[Course] ([courseID])
GO
ALTER TABLE [dbo].[CourseInstructor] CHECK CONSTRAINT [FK_CourseInstructor_Course]
GO
ALTER TABLE [dbo].[CourseInstructor]  WITH CHECK ADD  CONSTRAINT [FK_CourseInstructor_Instructor] FOREIGN KEY([instructorID])
REFERENCES [dbo].[Instructor] ([instructorID])
GO
ALTER TABLE [dbo].[CourseInstructor] CHECK CONSTRAINT [FK_CourseInstructor_Instructor]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Course] FOREIGN KEY([courseID])
REFERENCES [dbo].[Course] ([courseID])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_Course]
GO
ALTER TABLE [dbo].[Dog]  WITH CHECK ADD  CONSTRAINT [FK_Dog_Customer] FOREIGN KEY([customerID])
REFERENCES [dbo].[Customer] ([customerID])
GO
ALTER TABLE [dbo].[Dog] CHECK CONSTRAINT [FK_Dog_Customer]
GO
/****** Object:  StoredProcedure [dbo].[courseParticipants]    Script Date: 2020-02-07 19:12:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[courseParticipants]
@courseName nvarchar(50)
as
						 
select * from vwCourseParticpants
where Kursensnamn = @courseName
GO
/****** Object:  StoredProcedure [dbo].[spMasterInsertUpdateDeleteCourse]    Script Date: 2020-02-07 19:12:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[spMasterInsertUpdateDeleteCourse]
@CourseId INT, @CourseName NVARCHAR (50), @startDate DATE, @endDate DATE, @location NVARCHAR (50), @slots INT, @StatementType NVARCHAR (20)=''
AS
BEGIN
    IF @StatementType = 'Insert'
        INSERT  INTO Course (CourseName, startDate, endDate, location, slots)
        VALUES             (@CourseName, @startDate, @endDate, @location, @slots);
END
IF @StatementType = 'Select'
    BEGIN
        SELECT *
        FROM   Course;
    END
IF @StatementType = 'Update'
    BEGIN
        UPDATE Course
        SET    CourseName = @CourseName,
               startDate  = @startDate,
               endDate    = @endDate,
               location   = @location,
               slots      = @slots
        WHERE  courseID = @CourseId;
    END
ELSE
    IF @StatementType = 'Delete'
        BEGIN
            DELETE Course
            WHERE  courseID = @CourseId;
        END

GO
/****** Object:  StoredProcedure [dbo].[spSellCourse]    Script Date: 2020-02-07 19:12:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[spSellCourse]
@CourseID INT, @QuantityToSell INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        DECLARE @SlotsAvailable AS INT;
        SELECT @SlotsAvailable = slots
        FROM   Course
        WHERE  courseID = @CourseID;
        SELECT   @SlotsAvailable = SUM(Course.courseID)
        FROM     Course
        WHERE    Course.courseID = 2
        GROUP BY Course.courseID;
        SELECT   @QuantityToSell = SUM(CourseSales.courseID)
        FROM     CourseSales
                 INNER JOIN
                 Course
                 ON CourseSales.courseID = Course.courseID
        WHERE    CourseSales.courseID = 2
        GROUP BY CourseSales.courseID;
        IF (@SlotsAvailable < @QuantityToSell)
            BEGIN
                RAISERROR ('Enough slots are not available', 16, 1);
            END
        ELSE
            BEGIN
                UPDATE Course
                SET    slots = (slots - @QuantityToSell)
                WHERE  courseID = @CourseID;
                INSERT  INTO CourseSales (courseID)
                VALUES                  (@CourseID);
            END
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        SELECT ERROR_NUMBER() AS ErrorNumber,
               ERROR_MESSAGE() AS ErrorMessage,
               ERROR_PROCEDURE() AS ErrorProcedure,
               ERROR_STATE() AS ErrorState,
               ERROR_SEVERITY() AS ErrorSeverity,
               ERROR_LINE() AS ErrorLine;
    END CATCH
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Course"
            Begin Extent = 
               Top = 12
               Left = 76
               Bottom = 337
               Right = 351
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Customer"
            Begin Extent = 
               Top = 142
               Left = 694
               Bottom = 493
               Right = 969
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Dog"
            Begin Extent = 
               Top = 156
               Left = 1220
               Bottom = 465
               Right = 1495
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwCourseParticpants'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwCourseParticpants'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Course"
            Begin Extent = 
               Top = 12
               Left = 76
               Bottom = 259
               Right = 351
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Customer"
            Begin Extent = 
               Top = 206
               Left = 846
               Bottom = 453
               Right = 1121
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwCustomerCourse'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwCustomerCourse'
GO
USE [master]
GO
ALTER DATABASE [DogSchool] SET  READ_WRITE 
GO
