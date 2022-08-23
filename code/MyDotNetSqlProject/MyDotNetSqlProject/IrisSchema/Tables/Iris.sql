CREATE TABLE [IrisSchema].[Iris]
(
    [NewSepalLength]    DECIMAL (18) NOT NULL,
    [SepalWidth]     DECIMAL (18) NOT NULL,
    [PetalLength]    DECIMAL (18) NOT NULL,
    [PetalWidth]     DECIMAL (18) NOT NULL,
    [Variety]        VARCHAR (40) NOT NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = HASH([Variety]));
