CREATE TABLE [IrisSchema].[Iris] (
    [NewSepalLength] DECIMAL (18) NOT NULL,
    [SepalWidth]     DECIMAL (18) NOT NULL,
    [PetalLength]    DECIMAL (18) NOT NULL,
    [PetalWidth]     FLOAT (53)   NOT NULL,
    [Variety]        VARCHAR (30) NOT NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([Variety]));
GO
