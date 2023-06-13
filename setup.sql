SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE  [dbo].[DimAffiliateNetwork](
	[AffiliateNetworkId] [int] NOT NULL,
	[AffiliateNetworkId] [nvarchar](100) NULL
)

GO

CREATE TABLE [dbo].[DimAdvertisers](
	[AdvertiserId] [int] NOT NULL,
	[AdvertiserName] [nvarchar](100) NULL,
	[AffiliateNetworkId] [int] NOT NULL
),
CONSTRAINT FKAdvertisersAffiliateNetworkId 
	FOREIGN KEY (AffiliateNetworkId)
	REFERENCES DimAffiliateNetwork

GO



CREATE TABLE [dbo].[DimDomainNames](
	[DomainNameId] [int] NOT NULL,
	[DomainName] [nvarchar](100) NULL
)

GO

CREATE TABLE [dbo].[dimPartnerWebSites](
	[PartnerWebsiteId] [int] NOT NULL,
	[Name] [nvarchar](100) NULL
)

GO

CREATE TABLE [dbo].[DimPromotions](
	[PromotionId] [int] NOT NULL,
	[DomainNameId] [int] NULL,
	[ExpireDate]
),
CONSTRAINT FKPromotionsDomainNameId 
	FOREIGN KEY (DomainNameId)
	REFERENCES DimDomainNames

GO

CREATE TABLE [dbo].[orders](
	OrderId [int] NOT NULL,
	ClickId [int] NULL,
	CreatedOn [datetime],
	TransactionDate [datetime],
	SaleAmount [money] NOT NULL,
	CommissonAmount [money] NOT NULL,
	Currency [nvarchar](10) NOT NULL,
	AffiliateNetworkId [int] NULL,
	AdvertiserId [int] NULL
)

GO

