CREATE TABLE [IrisSchema].[Iris]
(
    [SepalLength] DECIMAL NOT NULL,
    [SepalWidth]  DECIMAL (18) NOT NULL,
    [PetalLength] DECIMAL (18) NOT NULL,
    [PetalWidth]  DECIMAL (18) NOT NULL,
    [Variety]     VARCHAR (30) NOT NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([Variety]));
