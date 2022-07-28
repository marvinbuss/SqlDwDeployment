CREATE TABLE [IrisSchema].[Iris]
(
    [NewSepalLength] [decimal](18,0) NOT NULL,
    [SepalWidth] [decimal](18,0) NOT NULL,
    [PetalLength] [decimal](18,0) NOT NULL,
    [PetalWidth] [float](53) NOT NULL,
    [Variety] [varchar](30) NOT NULL
)
WITH
(
    DISTRIBUTION = HASH ( [Variety] ),
    CLUSTERED COLUMNSTORE INDEX
)
GO
