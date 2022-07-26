CREATE TABLE [IrisSchema].[Sales]
(
  [Id] INT NOT NULL,
  [Variety] [varchar](30) NOT NULL,
  [Price] [decimal](5,2) NOT NULL
)
WITH
(
    DISTRIBUTION = HASH ( [Variety] ),
    CLUSTERED COLUMNSTORE INDEX
)
GO
