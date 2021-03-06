USE [DogSchool]
GO
/****** Object:  StoredProcedure [dbo].[spSellCourse]    Script Date: 2020-02-07 17:42:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER   PROCEDURE [dbo].[spSellCourse]
@CourseID INT, @QuantityToSell INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        DECLARE @SlotsAvailable AS INT;
        SELECT @SlotsAvailable = slots
        FROM   Course
        WHERE  courseID = @CourseID;

		--Do Count on slots avaialable from Course table
		--and put that in @SlotsAvailable

		SELECT  @SlotsAvailable = SUM(Course.courseID)
		FROM  Course 
				 
				 where Course.courseID=2
				 group by  Course.courseID

		--Do count on CourseSales table for CourseID, 
		--and put that in @QuantityToSell
		
		

		SELECT  @QuantityToSell = SUM(CourseSales.courseID)
		FROM  CourseSales INNER JOIN
				 Course ON CourseSales.courseID = Course.courseID
				 where CourseSales.courseID=2
				 group by  CourseSales.courseID

		 
		 

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

