-- This file contains SQL statements that will be executed before the build script.
PRINT('Pre Deployment Script')
GO

SELECT '$(InputParameter)'
GO
