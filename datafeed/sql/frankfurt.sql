-- Create the test database
CREATE DATABASE DataProviders;
GO
USE DataProviders;
EXEC sys.sp_cdc_enable_db;


CREATE TABLE frankfurt_stock_exchange (
  symbol CHAR(20) NOT NULL,
  bidprice MONEY,
  askprice MONEY,
  timestamp BIGINT
);

INSERT INTO [dbo].[frankfurt_stock_exchange]([symbol],[bidprice],[askprice],[timestamp]) VALUES ('ADR', 94.08, 149.55, 1672214742)
INSERT INTO [dbo].[frankfurt_stock_exchange]([symbol],[bidprice],[askprice],[timestamp]) VALUES ('ADR', 100.20, 149.55, 1672214742)
INSERT INTO [dbo].[frankfurt_stock_exchange]([symbol],[bidprice],[askprice],[timestamp]) VALUES ('BAE', 65.08, 149.55, 1672214742)
INSERT INTO [dbo].[frankfurt_stock_exchange]([symbol],[bidprice],[askprice],[timestamp]) VALUES ('EIB', 124.08, 149.03, 1672214742)
INSERT INTO [dbo].[frankfurt_stock_exchange]([symbol],[bidprice],[askprice],[timestamp]) VALUES ('ADR', 294.76, 120.92, 1672214742)

EXEC sys.sp_cdc_enable_table @source_schema = 'dbo', @source_name = 'frankfurt_stock_exchange', @role_name = NULL, @supports_net_changes = 0;

