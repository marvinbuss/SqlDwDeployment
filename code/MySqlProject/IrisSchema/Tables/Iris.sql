CREATE TABLE [IrisSchema].[Iris]
(
    [SepalLength] [decimal](18,0) NOT NULL,
    [SepalWidth] [decimal](18,0) NOT NULL,
    [PetalLength] [decimal](18,0) NOT NULL,
    [PetalWidth] [decimal](18,0) NOT NULL,
    [Variety] [varchar](30) NOT NULL
)
WITH
(
    DISTRIBUTION = HASH ( [Variety] ),
    CLUSTERED COLUMNSTORE INDEX
)
GO
