CREATE TABLE [IrisSchema].[Iris] (
    [SepalLength] DECIMAL (18) NOT NULL,
    [SepalWidth]  DECIMAL (18) NOT NULL,
    [PetalLength] DECIMAL (18) NOT NULL,
    [PetalWidth]  DECIMAL (18) NOT NULL,
    [Variety]     VARCHAR (50) NOT NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([Variety]));
GO
GRANT SELECT, INSERT, UPDATE, DELETE ON [IrisSchema].[Iris] TO [IrisOwner];
