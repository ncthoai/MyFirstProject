﻿CREATE DATABASE HotelManager
GO

USE HotelManager
GO

CREATE TABLE CUSTOMER_TYPE(
	CusTypeID CHAR(20) NOT NULL PRIMARY KEY,
	CusTypeName NVARCHAR(100) NOT NULL DEFAULT N'chưa đặt tên',
)
GO

CREATE TABLE CUSTOMER (
	CustomerID CHAR(20) NOT NULL PRIMARY KEY,
	CusName NVARCHAR(100) NOT NULL DEFAULT N'chưa đặt tên',
	CusAddress NVARCHAR(100) NOT NULL DEFAULT N'chưa ghi địa chỉ', 
	Phone INT DEFAULT 0909007113,
	IdentityCard INT NOT NULL,
	CusTypeID CHAR(20) NOT NULL,

	FOREIGN KEY (CusTypeID) REFERENCES dbo.CUSTOMER_TYPE(CusTypeID)

)
GO

CREATE TABLE ROOM_TYPE(
	RoomTypeID CHAR(20) NOT NULL PRIMARY KEY,
	RoomTypeName NVARCHAR(100) NOT NULL DEFAULT N'chưa đặt tên',
	RoomTypePrice MONEY NOT NULL,
	RoomTypeStatus INT NOT NULL DEFAULT 1 -- 1: còn phòng trống || 0: hết phòng

)
GO

CREATE TABLE ROOM(
	RoomID  CHAR(20) NOT NULL PRIMARY KEY,
	RoomName NVARCHAR(100) NOT NULL DEFAULT N'chưa đặt tên',
	RoomTypeID CHAR(20) NOT NULL,
	RoomNote NVARCHAR(100) DEFAULT N'chưa có ghi chú tên',
	RoomStatus INT NOT NULL DEFAULT 1, -- 1: có thể cho thuê || 0: đã đủ số lượng thuê

	FOREIGN KEY (RoomTypeID) REFERENCES dbo.ROOM_TYPE(RoomTypeID)
)
GO

CREATE TABLE RESERVATION(
	ReservationID CHAR(20) NOT NULL PRIMARY KEY,
	RoomID CHAR(20) NOT NULL,
	StartDay DATETIME NOT NULL DEFAULT GETDATE(),
	PaymentStatus INT NOT NULL DEFAULT 0, -- 1: đã thanh toán || 0: chưa thanh toán

	FOREIGN KEY (RoomID) REFERENCES dbo.ROOM(RoomID)

)
GO

CREATE TABLE RESERVATION_INFO(
	ReservationInfoID CHAR(20) NOT NULL PRIMARY KEY,
	ReservationID CHAR(20) NOT NULL,
	CustomerID CHAR(20) NOT NULL,

	FOREIGN KEY (ReservationID) REFERENCES dbo.RESERVATION(ReservationID),
	FOREIGN KEY (CustomerID) REFERENCES dbo.CUSTOMER(CustomerID)

)
GO


CREATE TABLE BILL (
	BillID CHAR(20) NOT NULL PRIMARY KEY,
	CustomerID CHAR(20) NOT NULL,
	Value FLOAT, -- Trị giá trong BM Hóa Đơn

	FOREIGN KEY (CustomerID) REFERENCES dbo.CUSTOMER(CustomerID)

)
GO

CREATE TABLE BILL_INFO (
	BillInfoID CHAR(20) NOT NULL PRIMARY KEY,
	BillID CHAR(20) NOT NULL,
	ReservationID CHAR(20) NOT NULL,
	NumOfDays INT NOT NULL,
	TotalPrice MONEY,

	FOREIGN KEY (BillID) REFERENCES dbo.BILL(BillID),
	FOREIGN KEY (ReservationID) REFERENCES dbo.RESERVATION(ReservationID)
)
GO


CREATE TABLE REVENUE (
	RevenueID CHAR(20) NOT NULL PRIMARY KEY,
	OnMonth INT NOT NULL,
	InYear INT NOT NULL,
	TotalRevenue MONEY
)
GO

CREATE TABLE REVENUE_INFO (
	RevenueInfoID CHAR(20) NOT NULL PRIMARY KEY,
	RevenueID CHAR(20) NOT NULL,
	RoomTypeID CHAR(20) NOT NULL,
	Revenue MONEY NOT NULL,
	Ratio FLOAT NOT NULL,
	
	FOREIGN KEY (RevenueID) REFERENCES dbo.REVENUE(RevenueID),
	FOREIGN KEY (RoomTypeID) REFERENCES dbo.ROOM_TYPE(RoomTypeID) 
)
GO









