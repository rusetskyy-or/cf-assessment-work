SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimAdvertisers](
	[AdvertiserId] [int] NOT NULL,
	[AdvertiserName] [nvarchar](100) NULL,
	[AffiliateNetworkId] [int] NOT NULL),
CONSTRAINT FKAdvertisersAdvertiserId 
	FOREIGN KEY (AdvertiserId)
	REFERENCES Orders

GO