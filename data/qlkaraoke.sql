USE [master]
GO
/****** Object:  Database [QLKARAOKE]    Script Date: 04/25/2023 10:59:30 AM ******/
CREATE DATABASE [QLKARAOKE]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QLKARAOKE', FILENAME = N'C:\DOAN3TK\QLKARAOKE.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QLKARAOKE_log', FILENAME = N'C:\DOAN3TK\QLKARAOKE_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [QLKARAOKE] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QLKARAOKE].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QLKARAOKE] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QLKARAOKE] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QLKARAOKE] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QLKARAOKE] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QLKARAOKE] SET ARITHABORT OFF 
GO
ALTER DATABASE [QLKARAOKE] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QLKARAOKE] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QLKARAOKE] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QLKARAOKE] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QLKARAOKE] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QLKARAOKE] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QLKARAOKE] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QLKARAOKE] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QLKARAOKE] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QLKARAOKE] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QLKARAOKE] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QLKARAOKE] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QLKARAOKE] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QLKARAOKE] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QLKARAOKE] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QLKARAOKE] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QLKARAOKE] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QLKARAOKE] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QLKARAOKE] SET  MULTI_USER 
GO
ALTER DATABASE [QLKARAOKE] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QLKARAOKE] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QLKARAOKE] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QLKARAOKE] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QLKARAOKE] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QLKARAOKE] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [QLKARAOKE] SET QUERY_STORE = OFF
GO
USE [QLKARAOKE]
GO
/****** Object:  Table [dbo].[ChucVu]    Script Date: 04/25/2023 10:59:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChucVu](
	[IDChucVu] [int] IDENTITY(1,1) NOT NULL,
	[TenChucVu] [nvarchar](50) NULL,
	[NgayCapNhat] [datetime] NULL,
	[LuongCV] [float] NULL,
 CONSTRAINT [PK_ChucVu] PRIMARY KEY CLUSTERED 
(
	[IDChucVu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CTKhoHang]    Script Date: 04/25/2023 10:59:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CTKhoHang](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TenSP] [nvarchar](50) NULL,
	[SoLuong] [int] NULL,
	[Ngay] [datetime] NULL,
	[TrangThai] [bit] NULL,
	[IdKh] [int] NULL,
	[ConLai] [int] NULL,
	[Gio] [time](7) NULL,
 CONSTRAINT [PK_CTKhoHang] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DatPhong]    Script Date: 04/25/2023 10:59:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DatPhong](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TimeStar] [time](7) NULL,
	[TimeEnd] [time](7) NULL,
	[Ngay] [datetime] NULL,
	[IdKH] [int] NULL,
	[IdDate] [int] NULL,
	[TrangThai] [int] NULL,
	[IdGG] [int] NULL,
	[ThanhTien] [float] NULL,
	[MaGG] [nvarchar](50) NULL,
	[Sdt] [varchar](20) NULL,
	[Email] [nvarchar](200) NULL,
	[MaDat] [nvarchar](50) NULL,
	[TenPhong] [nvarchar](50) NULL,
	[TienGiamGia] [float] NULL,
	[TienDichVu] [float] NULL,
	[Tienlich] [float] NULL,
	[LoaiP] [nvarchar](50) NULL,
	[TrangThaiNhan] [bit] NULL,
	[IdTime] [int] NULL,
	[IdLoai] [int] NULL,
	[IdPhong] [int] NULL,
	[IdLich] [int] NULL,
 CONSTRAINT [PK_DatPhong] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DaysOfWeeks]    Script Date: 04/25/2023 10:59:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DaysOfWeeks](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](30) NULL,
	[Gia] [float] NULL,
 CONSTRAINT [PK_DaysOfWeeks] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DichVu1]    Script Date: 04/25/2023 10:59:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DichVu1](
	[IDDichVu] [int] IDENTITY(1,1) NOT NULL,
	[IDKhoHang] [int] NULL,
	[DonGia] [float] NULL,
	[DVT] [nvarchar](50) NULL,
	[LoaiDV] [nvarchar](50) NULL,
	[HinhAnh] [nvarchar](50) NULL,
	[SoLuong] [int] NULL,
	[GiaBan] [float] NULL,
	[TongGia] [float] NULL,
	[DaBan] [int] NULL,
	[Ten] [nvarchar](50) NULL,
	[IdLoai] [int] NULL,
	[IDDVT] [int] NULL,
	[soluongthem] [int] NULL,
	[MoTa] [nvarchar](max) NULL,
 CONSTRAINT [PK_DichVu1] PRIMARY KEY CLUSTERED 
(
	[IDDichVu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DonViTinh]    Script Date: 04/25/2023 10:59:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DonViTinh](
	[IDDonVT] [int] IDENTITY(1,1) NOT NULL,
	[TenDonVi] [nvarchar](50) NULL,
	[NgayCapNhat] [datetime] NULL,
 CONSTRAINT [PK_DonViTinh] PRIMARY KEY CLUSTERED 
(
	[IDDonVT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiammGia]    Script Date: 04/25/2023 10:59:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiammGia](
	[IdGG] [int] IDENTITY(1,1) NOT NULL,
	[SoTien] [float] NULL,
	[code] [nvarchar](50) NOT NULL,
	[Soluong] [int] NOT NULL,
	[Idk] [int] NULL,
	[TrangThai] [bit] NULL,
 CONSTRAINT [PK_GiammGia] PRIMARY KEY CLUSTERED 
(
	[IdGG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HOADON]    Script Date: 04/25/2023 10:59:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HOADON](
	[IDHoaDon] [int] IDENTITY(1,1) NOT NULL,
	[IDDatPhong] [int] NOT NULL,
	[ThoiGianBatDau] [time](7) NULL,
	[ThoiGianKetThuc] [time](7) NULL,
	[ThanhTien] [float] NULL,
	[NoiDung] [nvarchar](max) NULL,
	[TienDv] [float] NULL,
	[TienGG] [float] NULL,
	[TienPhong] [float] NULL,
	[Ngay] [datetime] NULL,
	[Tenkh] [nvarchar](50) NULL,
	[TenP] [nvarchar](50) NULL,
	[TienThem] [float] NULL,
	[TienGiam] [float] NULL,
	[TrangThai] [bit] NULL,
	[SoLuong] [int] NULL,
	[IdSDDV] [int] NULL,
 CONSTRAINT [PK_HOADON] PRIMARY KEY CLUSTERED 
(
	[IDHoaDon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhachHangg]    Script Date: 04/25/2023 10:59:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhachHangg](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NOT NULL,
	[Password] [varchar](10) NOT NULL,
	[Email] [varchar](200) NULL,
	[Phone] [varchar](20) NULL,
	[Address] [nvarchar](250) NOT NULL,
	[Avata] [nvarchar](250) NULL,
	[Gender] [nvarchar](10) NULL,
 CONSTRAINT [PK__AccCusto__3214EC27F35B3D9D] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhoHang]    Script Date: 04/25/2023 10:59:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhoHang](
	[IDMatHang] [int] IDENTITY(1,1) NOT NULL,
	[TenMatHang] [nvarchar](50) NULL,
	[DonGia] [float] NOT NULL,
	[SoLuong] [int] NOT NULL,
	[NgayCapNhat] [datetime] NULL,
	[LoaiDv] [int] NULL,
	[IDDonVT] [int] NULL,
	[ConLai] [int] NOT NULL,
	[TongGia] [float] NULL,
	[Soluongthem] [int] NULL,
 CONSTRAINT [PK_KhoHang] PRIMARY KEY CLUSTERED 
(
	[IDMatHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LichDatP]    Script Date: 04/25/2023 10:59:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LichDatP](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdDate] [int] NULL,
	[IdLoai] [int] NULL,
	[IdPhong] [int] NULL,
	[TimeStar] [time](7) NULL,
	[TimeEnd] [time](7) NULL,
	[Ngay] [datetime] NULL,
	[TongGia] [float] NULL,
	[IdKh] [int] NULL,
	[Phone] [nvarchar](30) NULL,
	[Email] [nvarchar](50) NULL,
 CONSTRAINT [PK_LichDatP] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LienHe]    Script Date: 04/25/2023 10:59:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LienHe](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TenKH] [nvarchar](50) NULL,
	[NoiDung] [nvarchar](max) NULL,
	[SDT] [nchar](20) NULL,
	[Email] [nvarchar](50) NULL,
	[TrangThai] [int] NOT NULL,
	[NgayLH] [datetime] NOT NULL,
 CONSTRAINT [PK_LienHe] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiDV]    Script Date: 04/25/2023 10:59:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiDV](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TenDV] [nvarchar](50) NULL,
 CONSTRAINT [PK_LoaiDV] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiPhong]    Script Date: 04/25/2023 10:59:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiPhong](
	[IDLoaiPhong] [int] IDENTITY(1,1) NOT NULL,
	[TenPhong] [nvarchar](50) NULL,
	[DonGia] [float] NULL,
	[NgayCapNhat] [datetime] NULL,
 CONSTRAINT [PK_LoaiPhong] PRIMARY KEY CLUSTERED 
(
	[IDLoaiPhong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhanVien]    Script Date: 04/25/2023 10:59:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanVien](
	[IDNhanVien] [int] IDENTITY(1,1) NOT NULL,
	[HoTenNV] [nvarchar](50) NULL,
	[HinhAnh] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](50) NULL,
	[SDT] [nvarchar](50) NULL,
	[Luong] [float] NULL,
	[Email] [varchar](50) NULL,
	[TrangThai] [int] NULL,
	[GioiTinh] [nvarchar](10) NULL,
	[NgaySinh] [date] NULL,
	[IDChucVu] [int] NULL,
	[IdTin] [int] NULL,
	[IdKh] [int] NULL,
 CONSTRAINT [PK_NhanVien] PRIMARY KEY CLUSTERED 
(
	[IDNhanVien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Phong]    Script Date: 04/25/2023 10:59:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Phong](
	[IDPhong] [int] IDENTITY(1,1) NOT NULL,
	[TenPhong] [nvarchar](50) NULL,
	[DonGia] [float] NULL,
	[TrangThai] [bit] NULL,
	[NgayTao] [datetime] NOT NULL,
	[SoLuongNguoi] [int] NULL,
	[IDLoaiPhong] [int] NOT NULL,
	[HinhAnh] [nvarchar](250) NULL,
	[NoiDung] [nvarchar](max) NULL,
 CONSTRAINT [PK_Phong_1] PRIMARY KEY CLUSTERED 
(
	[IDPhong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuanLii]    Script Date: 04/25/2023 10:59:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuanLii](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Ten] [nvarchar](50) NULL,
	[Sdt] [nvarchar](15) NULL,
	[ChucVu] [nvarchar](50) NULL,
	[MatKhau] [nvarchar](250) NULL,
	[HinhAnh] [nvarchar](max) NULL,
	[Email] [nvarchar](50) NULL,
	[Gender] [nvarchar](50) NULL,
 CONSTRAINT [PK_Admin] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SuDungDichVu]    Script Date: 04/25/2023 10:59:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SuDungDichVu](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Ten] [nvarchar](50) NULL,
	[IDDv] [int] NULL,
	[SoLuong] [int] NULL,
	[Gia] [float] NULL,
	[TenDVT] [nvarchar](50) NULL,
	[TenLoai] [nvarchar](50) NULL,
	[Idkh] [int] NULL,
	[NgayTao] [datetime] NULL,
	[ThoiGianBatDat] [time](7) NULL,
	[IdDP] [int] NULL,
	[TrangThai] [bit] NULL,
 CONSTRAINT [PK_GioHang] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThongTin]    Script Date: 04/25/2023 10:59:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThongTin](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TieuDe] [nvarchar](max) NULL,
	[Hinhanh] [nvarchar](max) NULL,
	[Ngay] [date] NULL,
	[ThongTinn] [nvarchar](max) NULL,
 CONSTRAINT [PK_ThongTin] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Time]    Script Date: 04/25/2023 10:59:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Time](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TimeStar] [time](7) NULL,
	[TimeEnd] [time](7) NULL,
	[Gia] [float] NULL,
 CONSTRAINT [PK_Time] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TinTuc]    Script Date: 04/25/2023 10:59:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TinTuc](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TieuDe] [nvarchar](max) NULL,
	[NoiDung] [nvarchar](max) NULL,
	[ChucVuId] [int] NULL,
	[Hinhanh] [nvarchar](50) NULL,
	[TrangThai] [int] NULL,
	[Luong] [float] NULL,
	[Ngay] [date] NULL,
	[TrangThaiTin] [int] NULL,
	[Soluong] [int] NULL,
 CONSTRAINT [PK_TinTuc] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ChucVu] ON 

INSERT [dbo].[ChucVu] ([IDChucVu], [TenChucVu], [NgayCapNhat], [LuongCV]) VALUES (2, N'Quản Lý', CAST(N'2023-03-23T10:32:36.693' AS DateTime), 20000)
INSERT [dbo].[ChucVu] ([IDChucVu], [TenChucVu], [NgayCapNhat], [LuongCV]) VALUES (3, N'Nhân Viên', CAST(N'2023-03-17T11:47:34.607' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[ChucVu] OFF
GO
SET IDENTITY_INSERT [dbo].[CTKhoHang] ON 

INSERT [dbo].[CTKhoHang] ([Id], [TenSP], [SoLuong], [Ngay], [TrangThai], [IdKh], [ConLai], [Gio]) VALUES (5, N'Trái Cây', 10, CAST(N'2023-03-22T22:36:24.027' AS DateTime), 1, 4, 10, CAST(N'22:36:24.0271243' AS Time))
INSERT [dbo].[CTKhoHang] ([Id], [TenSP], [SoLuong], [Ngay], [TrangThai], [IdKh], [ConLai], [Gio]) VALUES (6, N'Giỏ Trái Cây', 8, CAST(N'2023-03-23T09:38:17.883' AS DateTime), 1, 7, 23, CAST(N'09:38:17.8847531' AS Time))
INSERT [dbo].[CTKhoHang] ([Id], [TenSP], [SoLuong], [Ngay], [TrangThai], [IdKh], [ConLai], [Gio]) VALUES (7, N'Giỏ Trái Cây', 8, CAST(N'2023-03-23T09:40:38.693' AS DateTime), 1, 7, 31, CAST(N'09:40:38.6935311' AS Time))
INSERT [dbo].[CTKhoHang] ([Id], [TenSP], [SoLuong], [Ngay], [TrangThai], [IdKh], [ConLai], [Gio]) VALUES (8, N'Bánh Tráng', 2, CAST(N'2023-03-23T09:47:41.160' AS DateTime), 1, 9, 16, CAST(N'09:47:41.1615437' AS Time))
INSERT [dbo].[CTKhoHang] ([Id], [TenSP], [SoLuong], [Ngay], [TrangThai], [IdKh], [ConLai], [Gio]) VALUES (13, N'Kẹo', 1, CAST(N'2023-03-23T09:58:54.957' AS DateTime), 1, 6, 5, CAST(N'09:58:54.9561391' AS Time))
INSERT [dbo].[CTKhoHang] ([Id], [TenSP], [SoLuong], [Ngay], [TrangThai], [IdKh], [ConLai], [Gio]) VALUES (16, N'Campuchino', 12, CAST(N'2023-03-23T18:56:51.600' AS DateTime), 0, 12, 12, CAST(N'18:56:51.6004529' AS Time))
INSERT [dbo].[CTKhoHang] ([Id], [TenSP], [SoLuong], [Ngay], [TrangThai], [IdKh], [ConLai], [Gio]) VALUES (18, N'Bánh Tráng', 3, CAST(N'2023-03-23T19:01:17.860' AS DateTime), 0, 9, 33, CAST(N'19:01:17.8596297' AS Time))
SET IDENTITY_INSERT [dbo].[CTKhoHang] OFF
GO
SET IDENTITY_INSERT [dbo].[DatPhong] ON 

INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (33, CAST(N'00:26:00' AS Time), CAST(N'00:29:00' AS Time), CAST(N'2023-03-17T07:55:43.063' AS DateTime), 1, 3, 1, NULL, NULL, NULL, N'03', N'huy@gmail.com', N'74BE7', N'A101', NULL, NULL, 120000, N'Phòng Thường', 1, NULL, 8, 11, NULL)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (34, CAST(N'03:26:00' AS Time), CAST(N'05:29:00' AS Time), CAST(N'2023-03-15T00:00:00.000' AS DateTime), 1, 3, 1, NULL, NULL, NULL, N'03', N'huy@gmail.com', N'94E3A', N'A101', NULL, NULL, 120000, N'Phòng Thường', 1, NULL, 8, 11, NULL)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (39, CAST(N'01:19:00' AS Time), CAST(N'03:20:00' AS Time), CAST(N'2023-03-18T00:00:00.000' AS DateTime), 1, 6, 1, NULL, NULL, NULL, N'03', N'huy@gmail.com', N'1CFA0', N'C201', NULL, NULL, 220000, N'Phòng Vip', 1, NULL, 8, 10, NULL)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (40, CAST(N'13:33:00' AS Time), CAST(N'05:33:00' AS Time), CAST(N'2023-03-18T00:00:00.000' AS DateTime), 1, 6, 1, NULL, NULL, NULL, N'03', N'huy@gmail.com', N'A522C', N'A202', NULL, NULL, 40000, N'Phòng Thường', 1, NULL, 8, 7, NULL)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (41, CAST(N'18:56:00' AS Time), CAST(N'22:56:00' AS Time), CAST(N'2023-03-19T00:00:00.000' AS DateTime), 1, 7, 1, NULL, NULL, NULL, N'03', N'huy@gmail.com', N'3701D', N'A101', 0, 0, NULL, N'Phòng Thường', 1, NULL, 8, 11, NULL)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (42, CAST(N'20:04:00' AS Time), CAST(N'22:04:00' AS Time), CAST(N'2023-03-15T00:00:00.000' AS DateTime), 5, 3, 1, NULL, NULL, NULL, N'1', N'huy2@gmail.com', N'EE823', N'B202', 0, 0, NULL, N'Phòng Vip', 1, NULL, 8, 8, NULL)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (43, CAST(N'19:11:00' AS Time), CAST(N'19:14:00' AS Time), CAST(N'2023-03-15T00:00:00.000' AS DateTime), 1, 3, 1, NULL, 210000, NULL, N'03', N'huy@gmail.com', N'849A4', N'C202', 0, 0, 210000, N'Phòng Vip', 1, NULL, 7, 9, NULL)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (44, CAST(N'19:16:00' AS Time), CAST(N'19:21:00' AS Time), CAST(N'2023-03-15T00:00:00.000' AS DateTime), 1, 3, 1, NULL, 110000, NULL, N'03', N'huy@gmail.com', N'F9802', N'A101', 0, 0, 110000, N'Phòng Thường', 1, NULL, 7, 11, NULL)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (45, CAST(N'19:40:00' AS Time), CAST(N'22:40:00' AS Time), CAST(N'2023-03-15T00:00:00.000' AS DateTime), 1, 3, 1, NULL, 620000, NULL, N'03', N'huy@gmail.com', N'BF6C3', N'C202', 0, 0, 620000, N'Phòng Vip', 1, NULL, 8, 9, NULL)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (46, CAST(N'08:33:00' AS Time), CAST(N'09:33:00' AS Time), CAST(N'2023-03-15T00:00:00.000' AS DateTime), 12, 3, 1, NULL, 500000, N'34B4EB525E', N'1', N'huy223@gmail.com', N'14C41', N'C201', 10000, 150000, 210000, N'Phòng Vip', 1, NULL, 7, 10, NULL)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (47, CAST(N'08:35:00' AS Time), CAST(N'09:35:00' AS Time), CAST(N'2023-03-15T00:00:00.000' AS DateTime), 12, 3, 1, NULL, 210000, NULL, N'1', N'huy223@gmail.com', N'36078', N'C201', 0, 0, 210000, N'Phòng Vip', 1, NULL, 7, 10, NULL)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (48, CAST(N'08:37:00' AS Time), CAST(N'08:39:00' AS Time), CAST(N'2023-03-15T00:00:00.000' AS DateTime), 12, 3, 1, NULL, 26000, NULL, N'1', N'huy223@gmail.com', N'E1EC4', N'C201', 0, 0, 26000, N'Phòng Vip', 1, NULL, 8, 10, NULL)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (49, CAST(N'08:41:00' AS Time), CAST(N'09:41:00' AS Time), CAST(N'2023-03-15T00:00:00.000' AS DateTime), 12, 3, 1, NULL, 210000, NULL, N'1', N'huy223@gmail.com', N'F799A', N'B202', 0, 0, 210000, N'Phòng Vip', 1, NULL, 7, 8, NULL)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (50, CAST(N'05:46:00' AS Time), CAST(N'08:46:00' AS Time), CAST(N'2023-03-19T00:00:00.000' AS DateTime), 1, 7, 1, NULL, 620000, NULL, N'03', N'huy@gmail.com', N'9F952', N'C201', 0, 0, 620000, N'Phòng Vip', 1, NULL, 8, 10, NULL)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (51, CAST(N'17:54:00' AS Time), CAST(N'21:54:00' AS Time), CAST(N'2023-03-19T00:00:00.000' AS DateTime), 12, 7, 1, NULL, 1070000, NULL, N'1', N'huy223@gmail.com', N'750C2', N'C201', 0, 250000, 820000, N'Phòng Vip', 1, NULL, 8, 10, NULL)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (53, CAST(N'05:59:00' AS Time), CAST(N'09:59:00' AS Time), CAST(N'2023-03-20T00:00:00.000' AS DateTime), 12, 1, 2, NULL, 820000, NULL, N'1', N'huy223@gmail.com', N'7183E', N'C201', 0, 0, 820000, N'Phòng Vip', 0, NULL, 8, 10, NULL)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (54, CAST(N'10:59:00' AS Time), CAST(N'13:01:00' AS Time), CAST(N'2023-03-20T00:00:00.000' AS DateTime), 7, 1, 2, NULL, 425999.99999999994, NULL, N'1', N'huy3@gmail.com', N'5AD1B', N'C201', 0, 0, 425999.99999999994, N'Phòng Vip', 0, NULL, 8, 10, NULL)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (55, CAST(N'09:59:00' AS Time), CAST(N'10:59:00' AS Time), CAST(N'2023-03-20T00:00:00.000' AS DateTime), 5, 1, 1, NULL, 220000, NULL, N'1', N'huy2@gmail.com', N'F1CB1', N'C201', 0, 0, 220000, N'Phòng Vip', 1, NULL, 8, 10, NULL)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (82, CAST(N'14:44:00' AS Time), CAST(N'16:44:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 12, NULL, 1, NULL, 420000, NULL, N'1', N'huy223@gmail.com', N'29E58', N'C201', 0, 0, 420000, N'Phòng Vip', 1, NULL, 8, 10, 167)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (83, CAST(N'17:11:00' AS Time), CAST(N'20:11:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 12, 4, 1, NULL, 620000, NULL, N'1', N'huy223@gmail.com', N'D097B', N'C201', 0, 0, 620000, N'Phòng Vip', 1, NULL, 8, 10, 180)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (86, CAST(N'20:56:00' AS Time), CAST(N'21:56:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 12, 4, 1, NULL, 220000, NULL, N'1', N'huy223@gmail.com', N'F0124', N'B202', 0, 0, 220000, N'Phòng Vip', 1, NULL, 8, 8, NULL)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (88, CAST(N'22:59:00' AS Time), CAST(N'23:59:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 12, 4, 1, NULL, 950000, NULL, N'1', N'huy223@gmail.com', N'B5B87', N'A101', 0, 840000, 110000, N'Phòng Thường', 1, NULL, 7, 11, 182)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (97, CAST(N'09:35:00' AS Time), CAST(N'11:35:00' AS Time), CAST(N'2023-03-17T00:00:00.000' AS DateTime), 12, 5, 1, NULL, 420000, NULL, N'1', N'huy223@gmail.com', N'F929A', N'A101', 0, 210000, 210000, N'Phòng Thường', 1, NULL, 7, 11, 200)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (98, CAST(N'13:55:00' AS Time), CAST(N'15:55:00' AS Time), CAST(N'2023-03-20T00:00:00.000' AS DateTime), 12, 1, 2, NULL, 210000, NULL, N'0385235236', N'huy223@gmail.com', N'76376', N'A101', 0, 0, 210000, N'Phòng Thường', 0, NULL, 7, 11, 202)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (99, CAST(N'08:40:00' AS Time), CAST(N'11:40:00' AS Time), CAST(N'2023-03-21T00:00:00.000' AS DateTime), 12, 2, 1, NULL, 1400000, NULL, N'0385235236', N'huy223@gmail.com', N'D413A', N'C201', 0, 780000, 620000, N'Phòng Vip', 1, NULL, 8, 10, 204)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (100, CAST(N'16:53:00' AS Time), CAST(N'18:53:00' AS Time), CAST(N'2023-03-21T00:00:00.000' AS DateTime), 12, 2, 1, NULL, 420000, NULL, N'0385235236', N'huy223@gmail.com', N'9C45E', N'A101', 0, 210000, 210000, N'Phòng Thường', 1, NULL, 7, 11, 206)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (101, CAST(N'17:23:00' AS Time), CAST(N'19:23:00' AS Time), CAST(N'2023-03-21T00:00:00.000' AS DateTime), 12, 2, 1, NULL, 50000, NULL, N'0385235236', N'huy223@gmail.com', N'242B2', N'A202', 0, 0, 50000, N'Phòng Thường', 1, NULL, 7, 7, 210)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (102, CAST(N'23:44:00' AS Time), CAST(N'23:59:00' AS Time), CAST(N'2023-03-21T00:00:00.000' AS DateTime), 12, 2, 1, NULL, 1471000, NULL, N'0385235236', N'huy223@gmail.com', N'6B187', N'A202', 0, 1456000, 15000, N'Phòng Thường', 1, NULL, 7, 7, 216)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (103, CAST(N'00:07:00' AS Time), CAST(N'03:07:00' AS Time), CAST(N'2023-03-22T00:00:00.000' AS DateTime), 12, 3, 1, NULL, 318000, NULL, N'0385235236', N'huy223@gmail.com', N'E806D', N'A202', 0, 248000, 70000, N'Phòng Thường', 1, NULL, 7, 7, 218)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (104, CAST(N'00:13:00' AS Time), CAST(N'02:13:00' AS Time), CAST(N'2023-03-22T00:00:00.000' AS DateTime), 12, 3, 1, NULL, 630000, NULL, N'0385235236', N'huy223@gmail.com', N'DBEFB', N'B202', 0, 210000, 420000, N'Phòng Vip', 1, NULL, 8, 8, 220)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (105, CAST(N'00:33:00' AS Time), CAST(N'03:33:00' AS Time), CAST(N'2023-03-22T00:00:00.000' AS DateTime), 12, 3, 1, NULL, 900000, NULL, N'0385235236', N'huy223@gmail.com', N'D34A9', N'C202', 0, 280000, 620000, N'Phòng Vip', 1, NULL, 8, 9, 222)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (106, CAST(N'00:55:00' AS Time), CAST(N'02:55:00' AS Time), CAST(N'2023-03-22T00:00:00.000' AS DateTime), 12, 3, 1, NULL, 680000, N'297C7630DF', N'0385235236', N'huy223@gmail.com', N'53A90', N'C201', 100000, 360000, 420000, N'Phòng Vip', 1, NULL, 8, 10, 224)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (107, CAST(N'09:02:00' AS Time), CAST(N'11:02:00' AS Time), CAST(N'2023-03-22T00:00:00.000' AS DateTime), 12, 3, 1, NULL, 540000, NULL, N'0385235236', N'huy223@gmail.com', N'D0C3A', N'A101', 0, 330000, 210000, N'Phòng Thường', 1, NULL, 7, 11, 226)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (108, CAST(N'09:02:00' AS Time), CAST(N'11:02:00' AS Time), CAST(N'2023-02-22T00:00:00.000' AS DateTime), 12, 3, 1, NULL, 540000, NULL, N'0385235236', N'huy223@gmail.com', N'D0C3A', N'A101', 0, 330000, 210000, N'Phòng Thường', 1, NULL, 7, 11, 226)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (109, CAST(N'18:50:00' AS Time), CAST(N'19:51:00' AS Time), CAST(N'2023-03-24T00:00:00.000' AS DateTime), 15, 5, 1, NULL, 122000, NULL, N'123', N'demo@gmail.com', N'C6B19', N'A101', 0, 0, 122000, N'Phòng Thường', 1, NULL, 7, 11, 236)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (110, CAST(N'06:51:00' AS Time), CAST(N'09:51:00' AS Time), CAST(N'2023-03-24T00:00:00.000' AS DateTime), 15, 5, 2, NULL, 320000, NULL, N'123', N'demo@gmail.com', N'7B71F', N'A101', 0, 0, 320000, N'Phòng Thường', 1, NULL, 7, 11, 238)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (111, CAST(N'10:52:00' AS Time), CAST(N'15:52:00' AS Time), CAST(N'2023-03-24T00:00:00.000' AS DateTime), 15, 5, 2, NULL, 520000, NULL, N'123', N'demo@gmail.com', N'B9BB4', N'A101', 0, 0, 520000, N'Phòng Thường', 1, NULL, 7, 11, 240)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (112, CAST(N'15:56:00' AS Time), CAST(N'18:48:00' AS Time), CAST(N'2023-03-24T00:00:00.000' AS DateTime), 15, 5, 2, NULL, 307000, NULL, N'123', N'demo@gmail.com', N'0987A', N'A101', 0, 0, 307000, N'Phòng Thường', 1, NULL, 7, 11, 244)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (115, CAST(N'22:52:00' AS Time), CAST(N'23:52:00' AS Time), CAST(N'2023-03-24T00:00:00.000' AS DateTime), 12, 5, 1, NULL, 40000, NULL, N'0385235236', N'huy223@gmail.com', N'C11CA', N'A202', 0, 0, 40000, N'Phòng Thường', 1, NULL, 7, 7, 250)
INSERT [dbo].[DatPhong] ([Id], [TimeStar], [TimeEnd], [Ngay], [IdKH], [IdDate], [TrangThai], [IdGG], [ThanhTien], [MaGG], [Sdt], [Email], [MaDat], [TenPhong], [TienGiamGia], [TienDichVu], [Tienlich], [LoaiP], [TrangThaiNhan], [IdTime], [IdLoai], [IdPhong], [IdLich]) VALUES (116, CAST(N'22:10:00' AS Time), CAST(N'23:59:00' AS Time), CAST(N'2023-03-23T00:00:00.000' AS DateTime), 12, 4, 1, NULL, 216400, NULL, N'0385235236', N'huy223@gmail.com', N'838F1', N'A202', 0, 160000, 56400, N'Phòng Thường', 1, NULL, 7, 7, 252)
SET IDENTITY_INSERT [dbo].[DatPhong] OFF
GO
SET IDENTITY_INSERT [dbo].[DaysOfWeeks] ON 

INSERT [dbo].[DaysOfWeeks] ([ID], [Name], [Gia]) VALUES (1, N'Thứ Hai', 0)
INSERT [dbo].[DaysOfWeeks] ([ID], [Name], [Gia]) VALUES (2, N'Thứ Ba', 0)
INSERT [dbo].[DaysOfWeeks] ([ID], [Name], [Gia]) VALUES (3, N'Thứ Tư', 0)
INSERT [dbo].[DaysOfWeeks] ([ID], [Name], [Gia]) VALUES (4, N'Thứ Năm', 10000)
INSERT [dbo].[DaysOfWeeks] ([ID], [Name], [Gia]) VALUES (5, N'Thứ Sáu', 10000)
INSERT [dbo].[DaysOfWeeks] ([ID], [Name], [Gia]) VALUES (6, N'Thứ Bảy', 20000)
INSERT [dbo].[DaysOfWeeks] ([ID], [Name], [Gia]) VALUES (7, N'Chủ Nhật', 30000)
SET IDENTITY_INSERT [dbo].[DaysOfWeeks] OFF
GO
SET IDENTITY_INSERT [dbo].[DichVu1] ON 

INSERT [dbo].[DichVu1] ([IDDichVu], [IDKhoHang], [DonGia], [DVT], [LoaiDV], [HinhAnh], [SoLuong], [GiaBan], [TongGia], [DaBan], [Ten], [IdLoai], [IDDVT], [soluongthem], [MoTa]) VALUES (15, 3, 200000, N'Thùng', N'Nước Uống', N'20230309082850851.jpg', 9, 10000, 210000, 40, N'bia', 3, 5, 3, NULL)
INSERT [dbo].[DichVu1] ([IDDichVu], [IDKhoHang], [DonGia], [DVT], [LoaiDV], [HinhAnh], [SoLuong], [GiaBan], [TongGia], [DaBan], [Ten], [IdLoai], [IDDVT], [soluongthem], [MoTa]) VALUES (16, 4, 100000, N'Giỏ', N'Đồ Ăn', N'20230323095159916.jpg', 9, 10000, 110000, 11, N'Trái Cây', 1, 4, 0, NULL)
INSERT [dbo].[DichVu1] ([IDDichVu], [IDKhoHang], [DonGia], [DVT], [LoaiDV], [HinhAnh], [SoLuong], [GiaBan], [TongGia], [DaBan], [Ten], [IdLoai], [IDDVT], [soluongthem], [MoTa]) VALUES (17, 5, 4000, N'Túi', N'Đồ Ăn', N'20230323095735468.jpg', 10, 10000, 14000, 2, N'Túi Bánh', 1, 6, 0, NULL)
INSERT [dbo].[DichVu1] ([IDDichVu], [IDKhoHang], [DonGia], [DVT], [LoaiDV], [HinhAnh], [SoLuong], [GiaBan], [TongGia], [DaBan], [Ten], [IdLoai], [IDDVT], [soluongthem], [MoTa]) VALUES (18, 6, 10000, N'Túi', N'Đồ Ăn', N'20230323095854950.jpg', 5, 20000, 30000, 12, N'Kẹo', 1, 6, 1, NULL)
INSERT [dbo].[DichVu1] ([IDDichVu], [IDKhoHang], [DonGia], [DVT], [LoaiDV], [HinhAnh], [SoLuong], [GiaBan], [TongGia], [DaBan], [Ten], [IdLoai], [IDDVT], [soluongthem], [MoTa]) VALUES (19, 7, 20000, N'Túi', N'Đồ Ăn', N'20230323094038685.png', 30, 30000, 50000, 4, N'Giỏ Trái Cây', 1, 6, 8, NULL)
INSERT [dbo].[DichVu1] ([IDDichVu], [IDKhoHang], [DonGia], [DVT], [LoaiDV], [HinhAnh], [SoLuong], [GiaBan], [TongGia], [DaBan], [Ten], [IdLoai], [IDDVT], [soluongthem], [MoTa]) VALUES (20, 8, 20000, N'Chai', N'Nước Uống', N'20230323095030667.jpg', 45, 30000, 50000, 7, N'Sting', 3, 7, 0, N'<p>aaaaaaaa</p>
')
INSERT [dbo].[DichVu1] ([IDDichVu], [IDKhoHang], [DonGia], [DVT], [LoaiDV], [HinhAnh], [SoLuong], [GiaBan], [TongGia], [DaBan], [Ten], [IdLoai], [IDDVT], [soluongthem], [MoTa]) VALUES (21, 9, 50000, N'Túi', N'Đồ Ăn', N'20230323094942681.jpg', 18, 50000, 100000, 0, N'Bánh Tráng', 1, 6, 0, N'<p>aaaaaaaaaaaa</p>
')
INSERT [dbo].[DichVu1] ([IDDichVu], [IDKhoHang], [DonGia], [DVT], [LoaiDV], [HinhAnh], [SoLuong], [GiaBan], [TongGia], [DaBan], [Ten], [IdLoai], [IDDVT], [soluongthem], [MoTa]) VALUES (22, 10, 20000, N'Chai', N'Nước Uống', N'Trà-sữa-cafe-thượng-hạng.png', 6, 10000, 30000, 0, N'Trà Sữa', 3, 7, NULL, NULL)
SET IDENTITY_INSERT [dbo].[DichVu1] OFF
GO
SET IDENTITY_INSERT [dbo].[DonViTinh] ON 

INSERT [dbo].[DonViTinh] ([IDDonVT], [TenDonVi], [NgayCapNhat]) VALUES (2, N'Lon', CAST(N'2023-02-26T14:48:02.983' AS DateTime))
INSERT [dbo].[DonViTinh] ([IDDonVT], [TenDonVi], [NgayCapNhat]) VALUES (3, N'Đĩa', CAST(N'2023-02-26T14:48:14.360' AS DateTime))
INSERT [dbo].[DonViTinh] ([IDDonVT], [TenDonVi], [NgayCapNhat]) VALUES (4, N'Giỏ', CAST(N'2023-02-26T14:48:24.663' AS DateTime))
INSERT [dbo].[DonViTinh] ([IDDonVT], [TenDonVi], [NgayCapNhat]) VALUES (5, N'Thùng', CAST(N'2023-02-26T14:48:49.473' AS DateTime))
INSERT [dbo].[DonViTinh] ([IDDonVT], [TenDonVi], [NgayCapNhat]) VALUES (6, N'Túi', CAST(N'2023-02-26T14:49:35.783' AS DateTime))
INSERT [dbo].[DonViTinh] ([IDDonVT], [TenDonVi], [NgayCapNhat]) VALUES (7, N'Chai', CAST(N'2023-02-26T15:01:40.430' AS DateTime))
SET IDENTITY_INSERT [dbo].[DonViTinh] OFF
GO
SET IDENTITY_INSERT [dbo].[GiammGia] ON 

INSERT [dbo].[GiammGia] ([IdGG], [SoTien], [code], [Soluong], [Idk], [TrangThai]) VALUES (13, 10000, N'261B34EC13', 0, 12, 0)
INSERT [dbo].[GiammGia] ([IdGG], [SoTien], [code], [Soluong], [Idk], [TrangThai]) VALUES (14, 100000, N'297C7630DF', 99, NULL, 1)
SET IDENTITY_INSERT [dbo].[GiammGia] OFF
GO
SET IDENTITY_INSERT [dbo].[HOADON] ON 

INSERT [dbo].[HOADON] ([IDHoaDon], [IDDatPhong], [ThoiGianBatDau], [ThoiGianKetThuc], [ThanhTien], [NoiDung], [TienDv], [TienGG], [TienPhong], [Ngay], [Tenkh], [TenP], [TienThem], [TienGiam], [TrangThai], [SoLuong], [IdSDDV]) VALUES (11, 99, CAST(N'08:40:00' AS Time), CAST(N'11:40:00' AS Time), 1400000, N'Đặt phòng karaoke', 780000, 0, 620000, CAST(N'2023-03-21T00:00:00.000' AS DateTime), N'huy23', N'C201', 0, 0, 1, NULL, NULL)
INSERT [dbo].[HOADON] ([IDHoaDon], [IDDatPhong], [ThoiGianBatDau], [ThoiGianKetThuc], [ThanhTien], [NoiDung], [TienDv], [TienGG], [TienPhong], [Ngay], [Tenkh], [TenP], [TienThem], [TienGiam], [TrangThai], [SoLuong], [IdSDDV]) VALUES (12, 102, CAST(N'23:44:00' AS Time), CAST(N'23:59:00' AS Time), 1471000, N'Đặt phòng karaoke', 1456000, 0, 15000, CAST(N'2023-03-21T00:00:00.000' AS DateTime), N'huy23', N'A202', 0, 0, 1, NULL, NULL)
INSERT [dbo].[HOADON] ([IDHoaDon], [IDDatPhong], [ThoiGianBatDau], [ThoiGianKetThuc], [ThanhTien], [NoiDung], [TienDv], [TienGG], [TienPhong], [Ngay], [Tenkh], [TenP], [TienThem], [TienGiam], [TrangThai], [SoLuong], [IdSDDV]) VALUES (13, 103, CAST(N'00:07:00' AS Time), CAST(N'03:07:00' AS Time), 318000, N'Đặt phòng karaoke', 248000, 0, 70000, CAST(N'2023-03-22T00:00:00.000' AS DateTime), N'huy23', N'A202', 0, 0, 1, NULL, NULL)
INSERT [dbo].[HOADON] ([IDHoaDon], [IDDatPhong], [ThoiGianBatDau], [ThoiGianKetThuc], [ThanhTien], [NoiDung], [TienDv], [TienGG], [TienPhong], [Ngay], [Tenkh], [TenP], [TienThem], [TienGiam], [TrangThai], [SoLuong], [IdSDDV]) VALUES (15, 105, CAST(N'00:33:00' AS Time), CAST(N'03:33:00' AS Time), 960000, N'Đặt phòng karaoke', 340000, 0, 620000, CAST(N'2023-03-22T00:00:00.000' AS DateTime), N'huy23', N'C202', 60000, 30000, 1, NULL, NULL)
INSERT [dbo].[HOADON] ([IDHoaDon], [IDDatPhong], [ThoiGianBatDau], [ThoiGianKetThuc], [ThanhTien], [NoiDung], [TienDv], [TienGG], [TienPhong], [Ngay], [Tenkh], [TenP], [TienThem], [TienGiam], [TrangThai], [SoLuong], [IdSDDV]) VALUES (16, 106, CAST(N'00:55:00' AS Time), CAST(N'02:55:00' AS Time), 530000, N'Đặt phòng karaoke', 210000, 100000, 420000, CAST(N'2023-03-22T00:00:00.000' AS DateTime), N'huy23', N'C201', 0, 150000, 1, NULL, NULL)
INSERT [dbo].[HOADON] ([IDHoaDon], [IDDatPhong], [ThoiGianBatDau], [ThoiGianKetThuc], [ThanhTien], [NoiDung], [TienDv], [TienGG], [TienPhong], [Ngay], [Tenkh], [TenP], [TienThem], [TienGiam], [TrangThai], [SoLuong], [IdSDDV]) VALUES (17, 107, CAST(N'09:02:00' AS Time), CAST(N'11:02:00' AS Time), 540000, N'<p>Đặt ph&ograve;ng karaoke12</p>
', 330000, 0, 210000, CAST(N'2023-03-22T00:00:00.000' AS DateTime), N'huy23', N'A101', 60000, 0, 1, NULL, NULL)
INSERT [dbo].[HOADON] ([IDHoaDon], [IDDatPhong], [ThoiGianBatDau], [ThoiGianKetThuc], [ThanhTien], [NoiDung], [TienDv], [TienGG], [TienPhong], [Ngay], [Tenkh], [TenP], [TienThem], [TienGiam], [TrangThai], [SoLuong], [IdSDDV]) VALUES (20, 108, CAST(N'09:02:00' AS Time), CAST(N'11:02:00' AS Time), 540000, N'<p>Đặt ph&ograve;ng karaoke12</p>', 900000, 0, 200000, CAST(N'2023-02-22T00:00:00.000' AS DateTime), N'huy23', N'A101', 60000, 0, 1, NULL, NULL)
INSERT [dbo].[HOADON] ([IDHoaDon], [IDDatPhong], [ThoiGianBatDau], [ThoiGianKetThuc], [ThanhTien], [NoiDung], [TienDv], [TienGG], [TienPhong], [Ngay], [Tenkh], [TenP], [TienThem], [TienGiam], [TrangThai], [SoLuong], [IdSDDV]) VALUES (26, 88, CAST(N'22:59:00' AS Time), CAST(N'23:59:00' AS Time), 950000, N'Đặt phòng karaoke', 840000, 0, 110000, CAST(N'2023-03-16T00:00:00.000' AS DateTime), N'huy23', N'A101', 0, 0, 1, NULL, NULL)
INSERT [dbo].[HOADON] ([IDHoaDon], [IDDatPhong], [ThoiGianBatDau], [ThoiGianKetThuc], [ThanhTien], [NoiDung], [TienDv], [TienGG], [TienPhong], [Ngay], [Tenkh], [TenP], [TienThem], [TienGiam], [TrangThai], [SoLuong], [IdSDDV]) VALUES (27, 97, CAST(N'09:35:00' AS Time), CAST(N'11:35:00' AS Time), 420000, N'Đặt phòng karaoke', 210000, 0, 210000, CAST(N'2023-03-17T00:00:00.000' AS DateTime), N'huy23', N'A101', 0, 0, 1, NULL, NULL)
INSERT [dbo].[HOADON] ([IDHoaDon], [IDDatPhong], [ThoiGianBatDau], [ThoiGianKetThuc], [ThanhTien], [NoiDung], [TienDv], [TienGG], [TienPhong], [Ngay], [Tenkh], [TenP], [TienThem], [TienGiam], [TrangThai], [SoLuong], [IdSDDV]) VALUES (28, 100, CAST(N'16:53:00' AS Time), CAST(N'18:53:00' AS Time), 420000, N'Đặt phòng karaoke', 210000, 0, 210000, CAST(N'2023-03-21T00:00:00.000' AS DateTime), N'huy23', N'A101', 0, 0, 1, NULL, NULL)
INSERT [dbo].[HOADON] ([IDHoaDon], [IDDatPhong], [ThoiGianBatDau], [ThoiGianKetThuc], [ThanhTien], [NoiDung], [TienDv], [TienGG], [TienPhong], [Ngay], [Tenkh], [TenP], [TienThem], [TienGiam], [TrangThai], [SoLuong], [IdSDDV]) VALUES (30, 46, CAST(N'08:33:00' AS Time), CAST(N'09:33:00' AS Time), 710000, N'Đặt phòng karaoke', 360000, 10000, 210000, CAST(N'2023-03-15T00:00:00.000' AS DateTime), N'huy23', N'C201', 0, 0, 1, NULL, NULL)
INSERT [dbo].[HOADON] ([IDHoaDon], [IDDatPhong], [ThoiGianBatDau], [ThoiGianKetThuc], [ThanhTien], [NoiDung], [TienDv], [TienGG], [TienPhong], [Ngay], [Tenkh], [TenP], [TienThem], [TienGiam], [TrangThai], [SoLuong], [IdSDDV]) VALUES (35, 51, CAST(N'17:54:00' AS Time), CAST(N'21:54:00' AS Time), 1070000, N'Đặt phòng karaoke', 250000, 0, 820000, CAST(N'2023-03-19T00:00:00.000' AS DateTime), N'huy23', N'C201', 0, 0, 1, NULL, NULL)
INSERT [dbo].[HOADON] ([IDHoaDon], [IDDatPhong], [ThoiGianBatDau], [ThoiGianKetThuc], [ThanhTien], [NoiDung], [TienDv], [TienGG], [TienPhong], [Ngay], [Tenkh], [TenP], [TienThem], [TienGiam], [TrangThai], [SoLuong], [IdSDDV]) VALUES (40, 83, CAST(N'17:11:00' AS Time), CAST(N'20:11:00' AS Time), 620000, N'Đặt phòng karaoke', 0, 0, 620000, CAST(N'2023-03-16T00:00:00.000' AS DateTime), N'huy23', N'C201', 0, 0, 1, NULL, NULL)
INSERT [dbo].[HOADON] ([IDHoaDon], [IDDatPhong], [ThoiGianBatDau], [ThoiGianKetThuc], [ThanhTien], [NoiDung], [TienDv], [TienGG], [TienPhong], [Ngay], [Tenkh], [TenP], [TienThem], [TienGiam], [TrangThai], [SoLuong], [IdSDDV]) VALUES (41, 86, CAST(N'20:56:00' AS Time), CAST(N'21:56:00' AS Time), 220000, N'Đặt phòng karaoke', 0, 0, 220000, CAST(N'2023-03-16T00:00:00.000' AS DateTime), N'huy23', N'B202', 0, 0, 1, NULL, NULL)
INSERT [dbo].[HOADON] ([IDHoaDon], [IDDatPhong], [ThoiGianBatDau], [ThoiGianKetThuc], [ThanhTien], [NoiDung], [TienDv], [TienGG], [TienPhong], [Ngay], [Tenkh], [TenP], [TienThem], [TienGiam], [TrangThai], [SoLuong], [IdSDDV]) VALUES (42, 115, CAST(N'22:52:00' AS Time), CAST(N'23:52:00' AS Time), 40000, N'Đặt phòng karaoke', 0, 0, 40000, CAST(N'2023-03-24T00:00:00.000' AS DateTime), N'Hoàng Huy', N'A202', 0, 0, 1, NULL, NULL)
INSERT [dbo].[HOADON] ([IDHoaDon], [IDDatPhong], [ThoiGianBatDau], [ThoiGianKetThuc], [ThanhTien], [NoiDung], [TienDv], [TienGG], [TienPhong], [Ngay], [Tenkh], [TenP], [TienThem], [TienGiam], [TrangThai], [SoLuong], [IdSDDV]) VALUES (1042, 116, CAST(N'22:10:00' AS Time), CAST(N'23:59:00' AS Time), 266400, N'Đặt phòng karaoke', 210000, 0, 56400, CAST(N'2023-03-23T00:00:00.000' AS DateTime), N'Hoàng Huy', N'A202', 0, 0, 0, NULL, NULL)
SET IDENTITY_INSERT [dbo].[HOADON] OFF
GO
SET IDENTITY_INSERT [dbo].[KhachHangg] ON 

INSERT [dbo].[KhachHangg] ([ID], [Name], [Password], [Email], [Phone], [Address], [Avata], [Gender]) VALUES (1, N'huy', N'123', N'huy@gmail.com', N'03', N'1', N'profile-img.jpg', NULL)
INSERT [dbo].[KhachHangg] ([ID], [Name], [Password], [Email], [Phone], [Address], [Avata], [Gender]) VALUES (5, N'huy', N'123', N'huy2@gmail.com', N'1', N'1', NULL, NULL)
INSERT [dbo].[KhachHangg] ([ID], [Name], [Password], [Email], [Phone], [Address], [Avata], [Gender]) VALUES (7, N'huy', N'123', N'huy3@gmail.com', N'1', N'1', N'profile-img.jpg', NULL)
INSERT [dbo].[KhachHangg] ([ID], [Name], [Password], [Email], [Phone], [Address], [Avata], [Gender]) VALUES (8, N'huy', N'123', N'huy4@gmail.com', N'1', N'1', NULL, NULL)
INSERT [dbo].[KhachHangg] ([ID], [Name], [Password], [Email], [Phone], [Address], [Avata], [Gender]) VALUES (9, N'huy', N'123', N'huy12@gmail.com', N'1', N'1', NULL, NULL)
INSERT [dbo].[KhachHangg] ([ID], [Name], [Password], [Email], [Phone], [Address], [Avata], [Gender]) VALUES (10, N'huy', N'123', N'1', N'1', N'1', NULL, NULL)
INSERT [dbo].[KhachHangg] ([ID], [Name], [Password], [Email], [Phone], [Address], [Avata], [Gender]) VALUES (11, N'1', N'1', N'huy', N'12', N'1', N'profile-img.jpg', N'Nam')
INSERT [dbo].[KhachHangg] ([ID], [Name], [Password], [Email], [Phone], [Address], [Avata], [Gender]) VALUES (12, N'Hoàng Huy', N'1234', N'huy223@gmail.com', N'0385235236', N'mỹ phước, bến cát', N'messages-3.jpg', N'Khác')
INSERT [dbo].[KhachHangg] ([ID], [Name], [Password], [Email], [Phone], [Address], [Avata], [Gender]) VALUES (13, N'huy', N'1', N'huy13@gmail.com', N'1', N'1', N'profile-img.jpg', N'Nam')
INSERT [dbo].[KhachHangg] ([ID], [Name], [Password], [Email], [Phone], [Address], [Avata], [Gender]) VALUES (15, N'demo', N'1', N'demo@gmail.com', N'123', N'1', N'profile-img.jpg', N'Nam')
SET IDENTITY_INSERT [dbo].[KhachHangg] OFF
GO
SET IDENTITY_INSERT [dbo].[KhoHang] ON 

INSERT [dbo].[KhoHang] ([IDMatHang], [TenMatHang], [DonGia], [SoLuong], [NgayCapNhat], [LoaiDv], [IDDonVT], [ConLai], [TongGia], [Soluongthem]) VALUES (3, N'bia', 200000, 56, CAST(N'2023-03-09T09:15:48.453' AS DateTime), 3, 5, 7, 11200000, 2)
INSERT [dbo].[KhoHang] ([IDMatHang], [TenMatHang], [DonGia], [SoLuong], [NgayCapNhat], [LoaiDv], [IDDonVT], [ConLai], [TongGia], [Soluongthem]) VALUES (4, N'Trái Cây', 100000, 20, CAST(N'2023-03-09T09:17:55.083' AS DateTime), 1, 4, 0, 2000000, 0)
INSERT [dbo].[KhoHang] ([IDMatHang], [TenMatHang], [DonGia], [SoLuong], [NgayCapNhat], [LoaiDv], [IDDonVT], [ConLai], [TongGia], [Soluongthem]) VALUES (5, N'Túi Bánh', 4000, 33, CAST(N'2023-03-23T18:51:48.890' AS DateTime), 1, 6, 23, 132000, 0)
INSERT [dbo].[KhoHang] ([IDMatHang], [TenMatHang], [DonGia], [SoLuong], [NgayCapNhat], [LoaiDv], [IDDonVT], [ConLai], [TongGia], [Soluongthem]) VALUES (6, N'Kẹo', 10000, 12, CAST(N'2023-03-09T09:19:27.590' AS DateTime), 1, 6, 1, 120000, 0)
INSERT [dbo].[KhoHang] ([IDMatHang], [TenMatHang], [DonGia], [SoLuong], [NgayCapNhat], [LoaiDv], [IDDonVT], [ConLai], [TongGia], [Soluongthem]) VALUES (7, N'Giỏ Trái Cây', 20000, 42, CAST(N'2023-03-21T09:00:49.660' AS DateTime), 1, 6, 11, 840000, 0)
INSERT [dbo].[KhoHang] ([IDMatHang], [TenMatHang], [DonGia], [SoLuong], [NgayCapNhat], [LoaiDv], [IDDonVT], [ConLai], [TongGia], [Soluongthem]) VALUES (8, N'Sting', 20000, 10000, CAST(N'2023-03-09T09:21:13.110' AS DateTime), 3, 7, 9945, 200000000, 0)
INSERT [dbo].[KhoHang] ([IDMatHang], [TenMatHang], [DonGia], [SoLuong], [NgayCapNhat], [LoaiDv], [IDDonVT], [ConLai], [TongGia], [Soluongthem]) VALUES (9, N'Bánh Tráng', 50000, 51, CAST(N'2023-03-23T19:01:17.840' AS DateTime), 1, 6, 33, 2550000, 0)
INSERT [dbo].[KhoHang] ([IDMatHang], [TenMatHang], [DonGia], [SoLuong], [NgayCapNhat], [LoaiDv], [IDDonVT], [ConLai], [TongGia], [Soluongthem]) VALUES (10, N'Trà Sữa', 20000, 21, CAST(N'2023-03-21T18:57:49.473' AS DateTime), 3, 7, 15, 420000, 0)
INSERT [dbo].[KhoHang] ([IDMatHang], [TenMatHang], [DonGia], [SoLuong], [NgayCapNhat], [LoaiDv], [IDDonVT], [ConLai], [TongGia], [Soluongthem]) VALUES (12, N'Campuchino', 100000, 15, CAST(N'2023-03-23T18:57:16.987' AS DateTime), 3, 7, 15, 1500000, 0)
SET IDENTITY_INSERT [dbo].[KhoHang] OFF
GO
SET IDENTITY_INSERT [dbo].[LichDatP] ON 

INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (139, NULL, 8, 10, CAST(N'13:05:00' AS Time), CAST(N'16:05:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 620000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (140, NULL, 8, 10, CAST(N'13:07:00' AS Time), CAST(N'17:07:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 820000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (141, NULL, 8, 10, CAST(N'13:08:00' AS Time), CAST(N'15:09:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 424000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (142, NULL, 8, 10, CAST(N'13:08:00' AS Time), CAST(N'15:09:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 424000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (143, NULL, 8, 10, CAST(N'13:08:00' AS Time), CAST(N'15:09:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 424000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (144, NULL, 8, 10, CAST(N'14:14:00' AS Time), CAST(N'16:14:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 420000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (145, NULL, 8, 10, CAST(N'14:14:00' AS Time), CAST(N'16:14:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 420000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (146, NULL, 8, 10, CAST(N'13:20:00' AS Time), CAST(N'15:20:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 420000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (147, NULL, 8, 10, CAST(N'13:20:00' AS Time), CAST(N'15:20:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 420000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (148, NULL, 8, 10, CAST(N'13:22:00' AS Time), CAST(N'17:22:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 820000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (149, NULL, 8, 10, CAST(N'13:22:00' AS Time), CAST(N'17:22:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 820000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (150, NULL, 8, 10, CAST(N'13:52:00' AS Time), CAST(N'17:52:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 820000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (151, NULL, 8, 10, CAST(N'13:52:00' AS Time), CAST(N'17:52:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 820000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (152, NULL, 7, 11, CAST(N'13:55:00' AS Time), CAST(N'15:57:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 212999.99999999997, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (153, NULL, 7, 11, CAST(N'13:55:00' AS Time), CAST(N'15:57:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 212999.99999999997, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (154, NULL, 8, 10, CAST(N'14:07:00' AS Time), CAST(N'17:07:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 620000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (155, NULL, 8, 10, CAST(N'14:07:00' AS Time), CAST(N'17:07:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 620000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (156, NULL, 8, 10, CAST(N'14:11:00' AS Time), CAST(N'17:11:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 620000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (157, NULL, 8, 10, CAST(N'14:11:00' AS Time), CAST(N'17:11:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 620000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (158, NULL, 8, 10, CAST(N'14:27:00' AS Time), CAST(N'15:27:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 220000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (159, NULL, 8, 10, CAST(N'14:27:00' AS Time), CAST(N'15:27:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 220000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (160, NULL, 8, 10, CAST(N'21:28:00' AS Time), CAST(N'22:28:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 220000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (161, NULL, 8, 10, CAST(N'21:28:00' AS Time), CAST(N'22:28:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 220000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (162, NULL, 8, 10, CAST(N'14:29:00' AS Time), CAST(N'14:35:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 40000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (163, NULL, 8, 10, CAST(N'14:29:00' AS Time), CAST(N'14:35:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 40000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (164, NULL, 8, 10, CAST(N'14:30:00' AS Time), CAST(N'15:30:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 220000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (165, NULL, 8, 10, CAST(N'14:30:00' AS Time), CAST(N'15:30:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 220000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (166, NULL, 8, 10, CAST(N'14:44:00' AS Time), CAST(N'16:44:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 420000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (167, NULL, 8, 10, CAST(N'14:44:00' AS Time), CAST(N'16:44:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 420000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (168, NULL, 8, 10, CAST(N'17:52:00' AS Time), CAST(N'18:45:00' AS Time), CAST(N'2023-03-17T00:00:00.000' AS DateTime), 196000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (169, NULL, 8, 10, CAST(N'17:52:00' AS Time), CAST(N'18:45:00' AS Time), CAST(N'2023-03-17T00:00:00.000' AS DateTime), 196000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (170, NULL, 8, 10, CAST(N'17:47:00' AS Time), CAST(N'20:47:00' AS Time), CAST(N'2023-03-17T00:00:00.000' AS DateTime), 620000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (171, NULL, 8, 10, CAST(N'17:47:00' AS Time), CAST(N'20:47:00' AS Time), CAST(N'2023-03-17T00:00:00.000' AS DateTime), 620000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (172, NULL, 7, 11, CAST(N'15:04:00' AS Time), CAST(N'18:04:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 310000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (173, NULL, 7, 11, CAST(N'15:04:00' AS Time), CAST(N'18:04:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 310000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (174, NULL, 8, 10, CAST(N'17:16:00' AS Time), CAST(N'18:17:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 224000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (175, NULL, 8, 10, CAST(N'17:16:00' AS Time), CAST(N'18:17:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 224000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (177, 4, 8, 10, CAST(N'16:59:00' AS Time), CAST(N'19:59:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 620000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (178, 4, 8, 10, CAST(N'16:59:00' AS Time), CAST(N'19:59:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 620000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (179, 4, 8, 10, CAST(N'17:11:00' AS Time), CAST(N'20:11:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 620000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (180, 4, 8, 10, CAST(N'17:11:00' AS Time), CAST(N'20:11:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 620000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (181, 4, 7, 11, CAST(N'22:59:00' AS Time), CAST(N'23:59:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 110000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (182, 4, 7, 11, CAST(N'22:59:00' AS Time), CAST(N'23:59:00' AS Time), CAST(N'2023-03-16T00:00:00.000' AS DateTime), 110000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (183, 5, 7, 11, CAST(N'06:51:00' AS Time), CAST(N'08:51:00' AS Time), CAST(N'2023-03-17T00:00:00.000' AS DateTime), 210000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (184, 5, 7, 11, CAST(N'06:51:00' AS Time), CAST(N'08:51:00' AS Time), CAST(N'2023-03-17T00:00:00.000' AS DateTime), 210000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (185, 5, 7, 11, CAST(N'07:16:00' AS Time), CAST(N'09:16:00' AS Time), CAST(N'2023-03-17T00:00:00.000' AS DateTime), 210000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (186, 5, 7, 11, CAST(N'07:16:00' AS Time), CAST(N'09:16:00' AS Time), CAST(N'2023-03-17T00:00:00.000' AS DateTime), 210000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (187, 5, 7, 11, CAST(N'07:19:00' AS Time), CAST(N'09:19:00' AS Time), CAST(N'2023-03-17T00:00:00.000' AS DateTime), 210000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (188, 5, 7, 11, CAST(N'07:19:00' AS Time), CAST(N'09:19:00' AS Time), CAST(N'2023-03-17T00:00:00.000' AS DateTime), 210000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (189, 5, 7, 11, CAST(N'07:33:00' AS Time), CAST(N'10:33:00' AS Time), CAST(N'2023-03-17T00:00:00.000' AS DateTime), 310000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (190, 5, 7, 11, CAST(N'07:33:00' AS Time), CAST(N'10:33:00' AS Time), CAST(N'2023-03-17T00:00:00.000' AS DateTime), 310000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (191, 5, 7, 11, CAST(N'07:39:00' AS Time), CAST(N'08:39:00' AS Time), CAST(N'2023-03-17T00:00:00.000' AS DateTime), 110000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (192, 5, 7, 11, CAST(N'07:39:00' AS Time), CAST(N'08:39:00' AS Time), CAST(N'2023-03-17T00:00:00.000' AS DateTime), 110000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (193, 5, 7, 11, CAST(N'07:41:00' AS Time), CAST(N'09:41:00' AS Time), CAST(N'2023-03-17T00:00:00.000' AS DateTime), 210000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (194, 5, 7, 11, CAST(N'07:41:00' AS Time), CAST(N'09:41:00' AS Time), CAST(N'2023-03-17T00:00:00.000' AS DateTime), 210000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (195, 5, 7, 11, CAST(N'08:42:00' AS Time), CAST(N'10:42:00' AS Time), CAST(N'2023-03-17T00:00:00.000' AS DateTime), 210000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (196, 5, 7, 11, CAST(N'08:42:00' AS Time), CAST(N'10:42:00' AS Time), CAST(N'2023-03-17T00:00:00.000' AS DateTime), 210000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (197, 5, 8, 9, CAST(N'09:50:00' AS Time), CAST(N'10:50:00' AS Time), CAST(N'2023-03-17T00:00:00.000' AS DateTime), 220000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (198, 5, 8, 9, CAST(N'09:50:00' AS Time), CAST(N'10:50:00' AS Time), CAST(N'2023-03-17T00:00:00.000' AS DateTime), 220000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (199, 5, 7, 11, CAST(N'09:35:00' AS Time), CAST(N'11:35:00' AS Time), CAST(N'2023-03-17T00:00:00.000' AS DateTime), 210000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (200, 5, 7, 11, CAST(N'09:35:00' AS Time), CAST(N'11:35:00' AS Time), CAST(N'2023-03-17T00:00:00.000' AS DateTime), 210000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (201, 1, 7, 11, CAST(N'13:55:00' AS Time), CAST(N'15:55:00' AS Time), CAST(N'2023-03-20T00:00:00.000' AS DateTime), 210000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (202, 1, 7, 11, CAST(N'13:55:00' AS Time), CAST(N'15:55:00' AS Time), CAST(N'2023-03-20T00:00:00.000' AS DateTime), 210000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (203, 2, 8, 10, CAST(N'08:40:00' AS Time), CAST(N'11:40:00' AS Time), CAST(N'2023-03-21T00:00:00.000' AS DateTime), 620000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (204, 2, 8, 10, CAST(N'08:40:00' AS Time), CAST(N'11:40:00' AS Time), CAST(N'2023-03-21T00:00:00.000' AS DateTime), 620000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (205, 2, 7, 11, CAST(N'16:53:00' AS Time), CAST(N'18:53:00' AS Time), CAST(N'2023-03-21T00:00:00.000' AS DateTime), 210000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (206, 2, 7, 11, CAST(N'16:53:00' AS Time), CAST(N'18:53:00' AS Time), CAST(N'2023-03-21T00:00:00.000' AS DateTime), 210000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (207, 2, 7, 7, CAST(N'17:23:00' AS Time), CAST(N'19:23:00' AS Time), CAST(N'2023-03-21T00:00:00.000' AS DateTime), 50000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (208, 2, 7, 7, CAST(N'17:23:00' AS Time), CAST(N'19:23:00' AS Time), CAST(N'2023-03-21T00:00:00.000' AS DateTime), 50000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (209, 2, 7, 7, CAST(N'17:23:00' AS Time), CAST(N'19:23:00' AS Time), CAST(N'2023-03-21T00:00:00.000' AS DateTime), 50000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (210, 2, 7, 7, CAST(N'17:23:00' AS Time), CAST(N'19:23:00' AS Time), CAST(N'2023-03-21T00:00:00.000' AS DateTime), 50000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (211, 2, 7, 7, CAST(N'00:43:00' AS Time), CAST(N'15:43:00' AS Time), CAST(N'2023-03-21T00:00:00.000' AS DateTime), 310000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (212, 2, 7, 7, CAST(N'00:43:00' AS Time), CAST(N'15:43:00' AS Time), CAST(N'2023-03-21T00:00:00.000' AS DateTime), 310000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (213, 2, 7, 7, CAST(N'00:43:00' AS Time), CAST(N'03:43:00' AS Time), CAST(N'2023-03-21T00:00:00.000' AS DateTime), 70000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (214, 2, 7, 7, CAST(N'00:43:00' AS Time), CAST(N'03:43:00' AS Time), CAST(N'2023-03-21T00:00:00.000' AS DateTime), 70000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (215, 2, 7, 7, CAST(N'23:44:00' AS Time), CAST(N'23:59:00' AS Time), CAST(N'2023-03-21T00:00:00.000' AS DateTime), 15000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (216, 2, 7, 7, CAST(N'23:44:00' AS Time), CAST(N'23:59:00' AS Time), CAST(N'2023-03-21T00:00:00.000' AS DateTime), 15000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (217, 3, 7, 7, CAST(N'00:07:00' AS Time), CAST(N'03:07:00' AS Time), CAST(N'2023-03-22T00:00:00.000' AS DateTime), 70000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (218, 3, 7, 7, CAST(N'00:07:00' AS Time), CAST(N'03:07:00' AS Time), CAST(N'2023-03-22T00:00:00.000' AS DateTime), 70000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (219, 3, 8, 8, CAST(N'00:13:00' AS Time), CAST(N'02:13:00' AS Time), CAST(N'2023-03-22T00:00:00.000' AS DateTime), 420000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (220, 3, 8, 8, CAST(N'00:13:00' AS Time), CAST(N'02:13:00' AS Time), CAST(N'2023-03-22T00:00:00.000' AS DateTime), 420000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (221, 3, 8, 9, CAST(N'00:33:00' AS Time), CAST(N'03:33:00' AS Time), CAST(N'2023-03-22T00:00:00.000' AS DateTime), 620000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (222, 3, 8, 9, CAST(N'00:33:00' AS Time), CAST(N'03:33:00' AS Time), CAST(N'2023-03-22T00:00:00.000' AS DateTime), 620000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (223, 3, 8, 10, CAST(N'00:55:00' AS Time), CAST(N'02:55:00' AS Time), CAST(N'2023-03-22T00:00:00.000' AS DateTime), 420000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (224, 3, 8, 10, CAST(N'00:55:00' AS Time), CAST(N'02:55:00' AS Time), CAST(N'2023-03-22T00:00:00.000' AS DateTime), 420000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (225, 3, 7, 11, CAST(N'09:02:00' AS Time), CAST(N'11:02:00' AS Time), CAST(N'2023-03-22T00:00:00.000' AS DateTime), 210000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (226, 3, 7, 11, CAST(N'09:02:00' AS Time), CAST(N'11:02:00' AS Time), CAST(N'2023-03-22T00:00:00.000' AS DateTime), 210000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (227, 3, 7, 7, CAST(N'09:11:00' AS Time), CAST(N'10:11:00' AS Time), CAST(N'2023-03-22T00:00:00.000' AS DateTime), 30000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (228, 3, 7, 7, CAST(N'09:11:00' AS Time), CAST(N'10:11:00' AS Time), CAST(N'2023-03-22T00:00:00.000' AS DateTime), 30000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (229, 4, 7, 7, CAST(N'09:25:00' AS Time), CAST(N'10:26:00' AS Time), CAST(N'2023-03-23T00:00:00.000' AS DateTime), 30400, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (230, 4, 7, 7, CAST(N'09:25:00' AS Time), CAST(N'10:26:00' AS Time), CAST(N'2023-03-23T00:00:00.000' AS DateTime), 30400, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (231, 4, 7, 7, CAST(N'09:25:00' AS Time), CAST(N'10:26:00' AS Time), CAST(N'2023-03-23T00:00:00.000' AS DateTime), 30400, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (232, 4, 7, 7, CAST(N'09:25:00' AS Time), CAST(N'10:26:00' AS Time), CAST(N'2023-03-23T00:00:00.000' AS DateTime), 30400, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (233, 4, 7, 7, CAST(N'09:25:00' AS Time), CAST(N'10:26:00' AS Time), CAST(N'2023-03-23T00:00:00.000' AS DateTime), 30400, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (234, 4, 7, 7, CAST(N'09:25:00' AS Time), CAST(N'10:26:00' AS Time), CAST(N'2023-03-23T00:00:00.000' AS DateTime), 30400, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (235, 5, 7, 11, CAST(N'18:50:00' AS Time), CAST(N'19:51:00' AS Time), CAST(N'2023-03-24T00:00:00.000' AS DateTime), 122000, 15, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (236, 5, 7, 11, CAST(N'18:50:00' AS Time), CAST(N'19:51:00' AS Time), CAST(N'2023-03-24T00:00:00.000' AS DateTime), 122000, 15, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (237, 5, 7, 11, CAST(N'06:51:00' AS Time), CAST(N'09:51:00' AS Time), CAST(N'2023-03-24T00:00:00.000' AS DateTime), 320000, 15, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (238, 5, 7, 11, CAST(N'06:51:00' AS Time), CAST(N'09:51:00' AS Time), CAST(N'2023-03-24T00:00:00.000' AS DateTime), 320000, 15, NULL, NULL)
GO
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (239, 5, 7, 11, CAST(N'10:52:00' AS Time), CAST(N'15:52:00' AS Time), CAST(N'2023-03-24T00:00:00.000' AS DateTime), 520000, 15, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (240, 5, 7, 11, CAST(N'10:52:00' AS Time), CAST(N'15:52:00' AS Time), CAST(N'2023-03-24T00:00:00.000' AS DateTime), 520000, 15, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (241, 5, 7, 11, CAST(N'15:56:00' AS Time), CAST(N'17:52:00' AS Time), CAST(N'2023-03-24T00:00:00.000' AS DateTime), 213000, 15, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (242, 5, 7, 11, CAST(N'15:56:00' AS Time), CAST(N'17:52:00' AS Time), CAST(N'2023-03-24T00:00:00.000' AS DateTime), 213000, 15, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (243, 5, 7, 11, CAST(N'15:56:00' AS Time), CAST(N'18:48:00' AS Time), CAST(N'2023-03-24T00:00:00.000' AS DateTime), 307000, 15, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (244, 5, 7, 11, CAST(N'15:56:00' AS Time), CAST(N'18:48:00' AS Time), CAST(N'2023-03-24T00:00:00.000' AS DateTime), 307000, 15, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (245, 5, 8, 10, CAST(N'07:57:00' AS Time), CAST(N'21:57:00' AS Time), CAST(N'2023-03-24T00:00:00.000' AS DateTime), 2830000, 15, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (246, 5, 8, 10, CAST(N'07:57:00' AS Time), CAST(N'21:57:00' AS Time), CAST(N'2023-03-24T00:00:00.000' AS DateTime), 2830000, 15, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (247, 5, 8, 10, CAST(N'09:00:00' AS Time), CAST(N'15:00:00' AS Time), CAST(N'2023-03-24T00:00:00.000' AS DateTime), 1230000, 15, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (248, 5, 8, 10, CAST(N'09:00:00' AS Time), CAST(N'15:00:00' AS Time), CAST(N'2023-03-24T00:00:00.000' AS DateTime), 1230000, 15, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (249, 5, 7, 7, CAST(N'22:52:00' AS Time), CAST(N'23:52:00' AS Time), CAST(N'2023-03-24T00:00:00.000' AS DateTime), 40000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (250, 5, 7, 7, CAST(N'22:52:00' AS Time), CAST(N'23:52:00' AS Time), CAST(N'2023-03-24T00:00:00.000' AS DateTime), 40000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (251, 4, 7, 7, CAST(N'22:10:00' AS Time), CAST(N'23:59:00' AS Time), CAST(N'2023-03-23T00:00:00.000' AS DateTime), 56400, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (252, 4, 7, 7, CAST(N'22:10:00' AS Time), CAST(N'23:59:00' AS Time), CAST(N'2023-03-23T00:00:00.000' AS DateTime), 56400, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (1249, 2, 7, 11, CAST(N'10:55:00' AS Time), CAST(N'12:55:00' AS Time), CAST(N'2023-04-25T00:00:00.000' AS DateTime), 210000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (1250, 2, 7, 11, CAST(N'10:55:00' AS Time), CAST(N'12:55:00' AS Time), CAST(N'2023-04-25T00:00:00.000' AS DateTime), 210000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (1251, 2, 7, 11, CAST(N'09:55:00' AS Time), CAST(N'12:55:00' AS Time), CAST(N'2023-04-25T00:00:00.000' AS DateTime), 310000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (1252, 2, 7, 11, CAST(N'09:55:00' AS Time), CAST(N'12:55:00' AS Time), CAST(N'2023-04-25T00:00:00.000' AS DateTime), 310000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (1253, 2, 7, 11, CAST(N'09:55:00' AS Time), CAST(N'12:55:00' AS Time), CAST(N'2023-04-25T00:00:00.000' AS DateTime), 310000, 12, NULL, NULL)
INSERT [dbo].[LichDatP] ([Id], [IdDate], [IdLoai], [IdPhong], [TimeStar], [TimeEnd], [Ngay], [TongGia], [IdKh], [Phone], [Email]) VALUES (1254, 2, 7, 11, CAST(N'09:55:00' AS Time), CAST(N'12:55:00' AS Time), CAST(N'2023-04-25T00:00:00.000' AS DateTime), 310000, 12, NULL, NULL)
SET IDENTITY_INSERT [dbo].[LichDatP] OFF
GO
SET IDENTITY_INSERT [dbo].[LienHe] ON 

INSERT [dbo].[LienHe] ([Id], [TenKH], [NoiDung], [SDT], [Email], [TrangThai], [NgayLH]) VALUES (3, N'huy', N'<p>1</p>', N'1                   ', N'huy@gmail.com', 1, CAST(N'2023-02-21T20:38:42.993' AS DateTime))
INSERT [dbo].[LienHe] ([Id], [TenKH], [NoiDung], [SDT], [Email], [TrangThai], [NgayLH]) VALUES (4, N'huy', N'<p>1</p>', N'2                   ', N'huy@gmail.com', 1, CAST(N'2023-02-21T20:41:12.923' AS DateTime))
SET IDENTITY_INSERT [dbo].[LienHe] OFF
GO
SET IDENTITY_INSERT [dbo].[LoaiDV] ON 

INSERT [dbo].[LoaiDV] ([ID], [TenDV]) VALUES (1, N'Đồ Ăn')
INSERT [dbo].[LoaiDV] ([ID], [TenDV]) VALUES (3, N'Nước Uống')
SET IDENTITY_INSERT [dbo].[LoaiDV] OFF
GO
SET IDENTITY_INSERT [dbo].[LoaiPhong] ON 

INSERT [dbo].[LoaiPhong] ([IDLoaiPhong], [TenPhong], [DonGia], [NgayCapNhat]) VALUES (7, N'Phòng Thường', 10000, CAST(N'2023-03-01T18:44:52.643' AS DateTime))
INSERT [dbo].[LoaiPhong] ([IDLoaiPhong], [TenPhong], [DonGia], [NgayCapNhat]) VALUES (8, N'Phòng Vip', 20000, CAST(N'2023-02-24T07:54:40.913' AS DateTime))
SET IDENTITY_INSERT [dbo].[LoaiPhong] OFF
GO
SET IDENTITY_INSERT [dbo].[NhanVien] ON 

INSERT [dbo].[NhanVien] ([IDNhanVien], [HoTenNV], [HinhAnh], [DiaChi], [SDT], [Luong], [Email], [TrangThai], [GioiTinh], [NgaySinh], [IDChucVu], [IdTin], [IdKh]) VALUES (1, N'Bùi Hoàng Huy', N'20230317203533683.jpg', N'abcd', N'0385235236', 7520000, N'huy@gmail.com', 1, N'Nam', CAST(N'2002-07-23' AS Date), 2, NULL, NULL)
INSERT [dbo].[NhanVien] ([IDNhanVien], [HoTenNV], [HinhAnh], [DiaChi], [SDT], [Luong], [Email], [TrangThai], [GioiTinh], [NgaySinh], [IDChucVu], [IdTin], [IdKh]) VALUES (2, N'Nguyên Văn Trường', N'20230302225215928.jpg', N'abc', N'4', 4500000, N'1', 1, N'Nam', CAST(N'2001-04-11' AS Date), 3, NULL, NULL)
INSERT [dbo].[NhanVien] ([IDNhanVien], [HoTenNV], [HinhAnh], [DiaChi], [SDT], [Luong], [Email], [TrangThai], [GioiTinh], [NgaySinh], [IDChucVu], [IdTin], [IdKh]) VALUES (1004, N'huy23', N'6be700c80d8944619bf5088482d56933.jpg', N'112', N'0385235236', 4500000, N'huy223@gmail.com', 1, N'Nam', CAST(N'2023-03-15' AS Date), 3, NULL, 12)
INSERT [dbo].[NhanVien] ([IDNhanVien], [HoTenNV], [HinhAnh], [DiaChi], [SDT], [Luong], [Email], [TrangThai], [GioiTinh], [NgaySinh], [IDChucVu], [IdTin], [IdKh]) VALUES (1006, N'Nguyen Van A', N'profile-img.jpg', N'1', N'021838134', 4500000, N'A@gmail.com', 2, N'Nam', CAST(N'2008-06-23' AS Date), 3, 11, 15)
INSERT [dbo].[NhanVien] ([IDNhanVien], [HoTenNV], [HinhAnh], [DiaChi], [SDT], [Luong], [Email], [TrangThai], [GioiTinh], [NgaySinh], [IDChucVu], [IdTin], [IdKh]) VALUES (1007, N'Nguyen Van B', N'profile-img.jpg', N'1', N'123', 4500000, N'B@gmail.com', 2, N'Nữ', CAST(N'2003-07-13' AS Date), 3, 9, 15)
SET IDENTITY_INSERT [dbo].[NhanVien] OFF
GO
SET IDENTITY_INSERT [dbo].[Phong] ON 

INSERT [dbo].[Phong] ([IDPhong], [TenPhong], [DonGia], [TrangThai], [NgayTao], [SoLuongNguoi], [IDLoaiPhong], [HinhAnh], [NoiDung]) VALUES (7, N'A202', 20000, 1, CAST(N'2023-03-23T09:35:58.157' AS DateTime), 12, 7, N'8d371660a0014e0f8067bbcca6cf28a2.jpg', N'<p>Qu&aacute;n karaoke ph&ograve;ng thường được thiết kế để tạo kh&ocirc;ng gian thoải m&aacute;i, sang trọng v&agrave; ph&ugrave; hợp cho những buổi h&aacute;t karaoke của nh&oacute;m bạn hoặc gia đ&igrave;nh. Ph&ograve;ng thường thường c&oacute; k&iacute;ch thước vừa phải, kh&ocirc;ng gian s&aacute;ng tạo với c&aacute;c hệ thống &acirc;m thanh, &aacute;nh s&aacute;ng v&agrave; m&agrave;n h&igrave;nh hiển thị chất lượng cao. Nội thất ph&ograve;ng thường thường được trang bị bằng sofa, b&agrave;n uống nước v&agrave; đồ trang tr&iacute; để tạo kh&ocirc;ng gian thư gi&atilde;n v&agrave; ấm c&uacute;ng. Một số ph&ograve;ng c&ograve;n được trang bị c&aacute;c tiện nghi kh&aacute;c như b&agrave;n ghế ăn, tủ lạnh, m&aacute;y lạnh... Nội dung ph&ograve;ng thường thường được trang tr&iacute; với h&igrave;nh ảnh c&aacute;c ca sĩ, nh&oacute;m nhạc nổi tiếng hoặc c&aacute;c trang tr&iacute; li&ecirc;n quan đến &acirc;m nhạc.</p>
')
INSERT [dbo].[Phong] ([IDPhong], [TenPhong], [DonGia], [TrangThai], [NgayTao], [SoLuongNguoi], [IDLoaiPhong], [HinhAnh], [NoiDung]) VALUES (8, N'B202', 200000, 1, CAST(N'2023-03-23T09:36:25.120' AS DateTime), 30, 8, N'thiet-ke-phong-hat-karaoke-binh-dan-1.jpg', N'<p>Đ&acirc;y l&agrave; mẫu ph&ograve;ng karaoke mang phong c&aacute;ch classic được rất nhiều kh&aacute;ch h&agrave;ng ưa chuộng năm nay. Mẫu ph&ograve;ng karaoke dạng n&agrave;y to&aacute;t l&ecirc;n vẻ đẹp hoa mỹ v&agrave; đẳng cấp. Sự phối hợp nhịp nh&agrave;ng tinh tế giữa những họa tiết hoa văn cầu kỳ kết hợp với m&agrave;n h&igrave;nh led hay k&iacute;nh phun c&aacute;t... tạo n&ecirc;n mẫu ph&ograve;ng karaoke ho&agrave;n hảo trong h&agrave;o nho&aacute;ng m&agrave; kh&ocirc;ng để chủ đầu tư n&agrave;o c&oacute; thể ch&ecirc; được. Gi&aacute; ph&ograve;ng karaoke dạng n&agrave;y giao động khoảng 6.5 đến 7 triệu /1m2 s&agrave;n.</p>
')
INSERT [dbo].[Phong] ([IDPhong], [TenPhong], [DonGia], [TrangThai], [NgayTao], [SoLuongNguoi], [IDLoaiPhong], [HinhAnh], [NoiDung]) VALUES (9, N'C202', 200000, 1, CAST(N'2023-03-23T09:36:18.010' AS DateTime), 40, 8, N'karaoke-Trong-Dong-phong-1-v2.jpg', N'<p>Đ&acirc;y l&agrave; mẫu ph&ograve;ng karaoke mang phong c&aacute;ch classic được rất nhiều kh&aacute;ch h&agrave;ng ưa chuộng năm nay. Mẫu ph&ograve;ng karaoke dạng n&agrave;y to&aacute;t l&ecirc;n vẻ đẹp hoa mỹ v&agrave; đẳng cấp. Sự phối hợp nhịp nh&agrave;ng tinh tế giữa những họa tiết hoa văn cầu kỳ kết hợp với m&agrave;n h&igrave;nh led hay k&iacute;nh phun c&aacute;t... tạo n&ecirc;n mẫu ph&ograve;ng karaoke ho&agrave;n hảo trong h&agrave;o nho&aacute;ng m&agrave; kh&ocirc;ng để chủ đầu tư n&agrave;o c&oacute; thể ch&ecirc; được. Gi&aacute; ph&ograve;ng karaoke dạng n&agrave;y giao động khoảng 6.5 đến 7 triệu /1m2 s&agrave;n.</p>
')
INSERT [dbo].[Phong] ([IDPhong], [TenPhong], [DonGia], [TrangThai], [NgayTao], [SoLuongNguoi], [IDLoaiPhong], [HinhAnh], [NoiDung]) VALUES (10, N'C201', 200000, 1, CAST(N'2023-03-23T09:32:51.720' AS DateTime), 35, 8, N'20230319201718775.jpg', N'<p>Đ&acirc;y l&agrave; mẫu ph&ograve;ng karaoke mang phong c&aacute;ch classic được rất nhiều kh&aacute;ch h&agrave;ng ưa chuộng năm nay. Mẫu ph&ograve;ng karaoke dạng n&agrave;y to&aacute;t l&ecirc;n vẻ đẹp hoa mỹ v&agrave; đẳng cấp. Sự phối hợp nhịp nh&agrave;ng tinh tế giữa những họa tiết hoa văn cầu kỳ kết hợp với m&agrave;n h&igrave;nh led hay k&iacute;nh phun c&aacute;t... tạo n&ecirc;n mẫu ph&ograve;ng karaoke ho&agrave;n hảo trong h&agrave;o nho&aacute;ng m&agrave; kh&ocirc;ng để chủ đầu tư n&agrave;o c&oacute; thể ch&ecirc; được. Gi&aacute; ph&ograve;ng karaoke dạng n&agrave;y giao động khoảng 6.5 đến 7 triệu /1m2 s&agrave;n.</p>
')
INSERT [dbo].[Phong] ([IDPhong], [TenPhong], [DonGia], [TrangThai], [NgayTao], [SoLuongNguoi], [IDLoaiPhong], [HinhAnh], [NoiDung]) VALUES (11, N'A101', 100000, 1, CAST(N'2023-03-23T09:35:49.780' AS DateTime), 10, 7, N'f9a6a3e2ec614462bd66da67fa878eaf.png', N'<p>Qu&aacute;n karaoke ph&ograve;ng thường được thiết kế để tạo kh&ocirc;ng gian thoải m&aacute;i, sang trọng v&agrave; ph&ugrave; hợp cho những buổi h&aacute;t karaoke của nh&oacute;m bạn hoặc gia đ&igrave;nh. Ph&ograve;ng thường thường c&oacute; k&iacute;ch thước vừa phải, kh&ocirc;ng gian s&aacute;ng tạo với c&aacute;c hệ thống &acirc;m thanh, &aacute;nh s&aacute;ng v&agrave; m&agrave;n h&igrave;nh hiển thị chất lượng cao. Nội thất ph&ograve;ng thường thường được trang bị bằng sofa, b&agrave;n uống nước v&agrave; đồ trang tr&iacute; để tạo kh&ocirc;ng gian thư gi&atilde;n v&agrave; ấm c&uacute;ng. Một số ph&ograve;ng c&ograve;n được trang bị c&aacute;c tiện nghi kh&aacute;c như b&agrave;n ghế ăn, tủ lạnh, m&aacute;y lạnh... Nội dung ph&ograve;ng thường thường được trang tr&iacute; với h&igrave;nh ảnh c&aacute;c ca sĩ, nh&oacute;m nhạc nổi tiếng hoặc c&aacute;c trang tr&iacute; li&ecirc;n quan đến &acirc;m nhạc.</p>
')
SET IDENTITY_INSERT [dbo].[Phong] OFF
GO
SET IDENTITY_INSERT [dbo].[QuanLii] ON 

INSERT [dbo].[QuanLii] ([Id], [Ten], [Sdt], [ChucVu], [MatKhau], [HinhAnh], [Email], [Gender]) VALUES (1, N'hoàng huy', N'0385235236', N'Quản Lý', N'1', N'profile-img.jpg', N'huy@gmail.com', N'nam')
INSERT [dbo].[QuanLii] ([Id], [Ten], [Sdt], [ChucVu], [MatKhau], [HinhAnh], [Email], [Gender]) VALUES (2, N'hoàng huy1', N'0385235236', N'Quản lý', N'1', N'profile-img.jpg', N'huy1@gmail.com', N'Nam')
SET IDENTITY_INSERT [dbo].[QuanLii] OFF
GO
SET IDENTITY_INSERT [dbo].[SuDungDichVu] ON 

INSERT [dbo].[SuDungDichVu] ([ID], [Ten], [IDDv], [SoLuong], [Gia], [TenDVT], [TenLoai], [Idkh], [NgayTao], [ThoiGianBatDat], [IdDP], [TrangThai]) VALUES (1, N'Sting', 20, 5, 50000, N'Chai', N'Nước Uống', 12, CAST(N'2023-03-19T00:00:00.000' AS DateTime), CAST(N'17:54:00' AS Time), 51, NULL)
INSERT [dbo].[SuDungDichVu] ([ID], [Ten], [IDDv], [SoLuong], [Gia], [TenDVT], [TenLoai], [Idkh], [NgayTao], [ThoiGianBatDat], [IdDP], [TrangThai]) VALUES (2, N'bia', 15, 4, 210000, N'Thùng', N'Nước Uống', 12, CAST(N'2023-03-16T00:00:00.000' AS DateTime), CAST(N'22:59:00' AS Time), 88, 1)
INSERT [dbo].[SuDungDichVu] ([ID], [Ten], [IDDv], [SoLuong], [Gia], [TenDVT], [TenLoai], [Idkh], [NgayTao], [ThoiGianBatDat], [IdDP], [TrangThai]) VALUES (18, N'bia', 15, 1, 210000, N'Thùng', N'Nước Uống', 12, CAST(N'2023-03-17T00:00:00.000' AS DateTime), CAST(N'09:35:00' AS Time), 97, 1)
INSERT [dbo].[SuDungDichVu] ([ID], [Ten], [IDDv], [SoLuong], [Gia], [TenDVT], [TenLoai], [Idkh], [NgayTao], [ThoiGianBatDat], [IdDP], [TrangThai]) VALUES (19, N'Kẹo', NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[SuDungDichVu] ([ID], [Ten], [IDDv], [SoLuong], [Gia], [TenDVT], [TenLoai], [Idkh], [NgayTao], [ThoiGianBatDat], [IdDP], [TrangThai]) VALUES (20, N'bia', 15, 5, 210000, N'Thùng', N'Nước Uống', 12, CAST(N'2023-03-21T00:00:00.000' AS DateTime), CAST(N'08:40:00' AS Time), 99, 1)
INSERT [dbo].[SuDungDichVu] ([ID], [Ten], [IDDv], [SoLuong], [Gia], [TenDVT], [TenLoai], [Idkh], [NgayTao], [ThoiGianBatDat], [IdDP], [TrangThai]) VALUES (22, N'bia', 15, 1, 210000, N'Thùng', N'Nước Uống', 12, CAST(N'2023-03-21T00:00:00.000' AS DateTime), CAST(N'16:53:00' AS Time), 100, 1)
INSERT [dbo].[SuDungDichVu] ([ID], [Ten], [IDDv], [SoLuong], [Gia], [TenDVT], [TenLoai], [Idkh], [NgayTao], [ThoiGianBatDat], [IdDP], [TrangThai]) VALUES (23, N'bia', 15, 1, 210000, N'Thùng', N'Nước Uống', 12, CAST(N'2023-03-21T00:00:00.000' AS DateTime), CAST(N'23:44:00' AS Time), 102, 1)
INSERT [dbo].[SuDungDichVu] ([ID], [Ten], [IDDv], [SoLuong], [Gia], [TenDVT], [TenLoai], [Idkh], [NgayTao], [ThoiGianBatDat], [IdDP], [TrangThai]) VALUES (24, N'Trái Cây', 16, 1, 110000, N'Giỏ', N'Đồ Ăn', 12, CAST(N'2023-03-21T00:00:00.000' AS DateTime), CAST(N'23:44:00' AS Time), 102, 1)
INSERT [dbo].[SuDungDichVu] ([ID], [Ten], [IDDv], [SoLuong], [Gia], [TenDVT], [TenLoai], [Idkh], [NgayTao], [ThoiGianBatDat], [IdDP], [TrangThai]) VALUES (25, N'Túi Bánh', 17, 1, 14000, N'Túi', N'Đồ Ăn', 12, CAST(N'2023-03-21T00:00:00.000' AS DateTime), CAST(N'23:44:00' AS Time), 102, 1)
INSERT [dbo].[SuDungDichVu] ([ID], [Ten], [IDDv], [SoLuong], [Gia], [TenDVT], [TenLoai], [Idkh], [NgayTao], [ThoiGianBatDat], [IdDP], [TrangThai]) VALUES (26, N'Kẹo', 18, 1, 30000, N'Túi', N'Đồ Ăn', 12, CAST(N'2023-03-21T00:00:00.000' AS DateTime), CAST(N'23:44:00' AS Time), 102, 1)
INSERT [dbo].[SuDungDichVu] ([ID], [Ten], [IDDv], [SoLuong], [Gia], [TenDVT], [TenLoai], [Idkh], [NgayTao], [ThoiGianBatDat], [IdDP], [TrangThai]) VALUES (27, N'Trái Cây', 16, 1, 110000, N'Giỏ', N'Đồ Ăn', 12, CAST(N'2023-03-22T00:00:00.000' AS DateTime), CAST(N'00:07:00' AS Time), 103, 1)
INSERT [dbo].[SuDungDichVu] ([ID], [Ten], [IDDv], [SoLuong], [Gia], [TenDVT], [TenLoai], [Idkh], [NgayTao], [ThoiGianBatDat], [IdDP], [TrangThai]) VALUES (28, N'Túi Bánh', 17, 1, 14000, N'Túi', N'Đồ Ăn', 12, CAST(N'2023-03-22T00:00:00.000' AS DateTime), CAST(N'00:07:00' AS Time), 103, 1)
INSERT [dbo].[SuDungDichVu] ([ID], [Ten], [IDDv], [SoLuong], [Gia], [TenDVT], [TenLoai], [Idkh], [NgayTao], [ThoiGianBatDat], [IdDP], [TrangThai]) VALUES (29, N'bia', 15, 0, 210000, N'Thùng', N'Nước Uống', 12, CAST(N'2023-03-22T00:00:00.000' AS DateTime), CAST(N'00:13:00' AS Time), 104, 1)
INSERT [dbo].[SuDungDichVu] ([ID], [Ten], [IDDv], [SoLuong], [Gia], [TenDVT], [TenLoai], [Idkh], [NgayTao], [ThoiGianBatDat], [IdDP], [TrangThai]) VALUES (30, N'Trái Cây', 16, 2, 110000, N'Giỏ', N'Đồ Ăn', 12, CAST(N'2023-03-22T00:00:00.000' AS DateTime), CAST(N'00:33:00' AS Time), 105, 1)
INSERT [dbo].[SuDungDichVu] ([ID], [Ten], [IDDv], [SoLuong], [Gia], [TenDVT], [TenLoai], [Idkh], [NgayTao], [ThoiGianBatDat], [IdDP], [TrangThai]) VALUES (31, N'Kẹo', 18, 4, 30000, N'Túi', N'Đồ Ăn', 12, CAST(N'2023-03-22T00:00:00.000' AS DateTime), CAST(N'00:33:00' AS Time), 105, 1)
INSERT [dbo].[SuDungDichVu] ([ID], [Ten], [IDDv], [SoLuong], [Gia], [TenDVT], [TenLoai], [Idkh], [NgayTao], [ThoiGianBatDat], [IdDP], [TrangThai]) VALUES (32, N'Trái Cây', 16, 1, 110000, N'Giỏ', N'Đồ Ăn', 12, CAST(N'2023-03-22T00:00:00.000' AS DateTime), CAST(N'00:55:00' AS Time), 106, 1)
INSERT [dbo].[SuDungDichVu] ([ID], [Ten], [IDDv], [SoLuong], [Gia], [TenDVT], [TenLoai], [Idkh], [NgayTao], [ThoiGianBatDat], [IdDP], [TrangThai]) VALUES (33, N'Sting', 20, 2, 50000, N'Chai', N'Nước Uống', 12, CAST(N'2023-03-22T00:00:00.000' AS DateTime), CAST(N'00:55:00' AS Time), 106, 1)
INSERT [dbo].[SuDungDichVu] ([ID], [Ten], [IDDv], [SoLuong], [Gia], [TenDVT], [TenLoai], [Idkh], [NgayTao], [ThoiGianBatDat], [IdDP], [TrangThai]) VALUES (34, N'bia', 15, 1, 210000, N'Thùng', N'Nước Uống', 12, CAST(N'2023-03-22T00:00:00.000' AS DateTime), CAST(N'09:02:00' AS Time), 107, 1)
INSERT [dbo].[SuDungDichVu] ([ID], [Ten], [IDDv], [SoLuong], [Gia], [TenDVT], [TenLoai], [Idkh], [NgayTao], [ThoiGianBatDat], [IdDP], [TrangThai]) VALUES (35, N'Kẹo', 18, 4, 30000, N'Túi', N'Đồ Ăn', 12, CAST(N'2023-03-22T00:00:00.000' AS DateTime), CAST(N'09:02:00' AS Time), 107, 1)
INSERT [dbo].[SuDungDichVu] ([ID], [Ten], [IDDv], [SoLuong], [Gia], [TenDVT], [TenLoai], [Idkh], [NgayTao], [ThoiGianBatDat], [IdDP], [TrangThai]) VALUES (36, N'Trái Cây', 16, 1, 110000, N'Giỏ', N'Đồ Ăn', 12, CAST(N'2023-03-23T00:00:00.000' AS DateTime), CAST(N'22:10:00' AS Time), 116, 1)
INSERT [dbo].[SuDungDichVu] ([ID], [Ten], [IDDv], [SoLuong], [Gia], [TenDVT], [TenLoai], [Idkh], [NgayTao], [ThoiGianBatDat], [IdDP], [TrangThai]) VALUES (37, N'Giỏ Trái Cây', 19, 1, 50000, N'Túi', N'Đồ Ăn', 12, CAST(N'2023-03-23T00:00:00.000' AS DateTime), CAST(N'22:10:00' AS Time), 116, 1)
SET IDENTITY_INSERT [dbo].[SuDungDichVu] OFF
GO
SET IDENTITY_INSERT [dbo].[ThongTin] ON 

INSERT [dbo].[ThongTin] ([Id], [TieuDe], [Hinhanh], [Ngay], [ThongTinn]) VALUES (1, N'<p><strong>KaraOke- Naraka</strong></p>
', N'20230319204640583.jpg', CAST(N'2023-03-19' AS Date), N'<h2><strong>I. C&aacute;ch l&agrave;m phục vụ qu&aacute;n karaoke</strong></h2>

<p>C&aacute;ch phục vụ qu&aacute;n karaoke&nbsp;</p>

<h3><strong>1.1. Quy tr&igrave;nh đ&oacute;n tiếp</strong></h3>

<p>Quy tr&igrave;nh đ&oacute;n tiếp kh&aacute;ch h&agrave;ng tại qu&aacute;n karaoke bao gồm c&aacute;c bước:</p>

<ul>
	<li>
	<p>Bước 1: Niềm nở, ch&agrave;o đ&oacute;n khi c&oacute; kh&aacute;ch h&agrave;ng đến qu&aacute;n.</p>
	</li>
	<li>
	<p>Bước 2: Hỏi kh&aacute;ch đ&atilde; đặt ph&ograve;ng trước hay mới bắt đầu đến qu&aacute;n đặt.</p>
	</li>
	<li>
	<p>Bước 3: Trường hợp kh&aacute;ch h&agrave;ng đ&atilde; đặt ph&ograve;ng trước, nh&acirc;n vi&ecirc;n c&oacute; thể hỏi lại số ph&ograve;ng v&agrave; kiểm tra th&ocirc;ng tin của kh&aacute;ch. Trường hợp kh&aacute;ch chưa đặt ph&ograve;ng th&igrave; nh&acirc;n vi&ecirc;n sẽ kiểm tra danh s&aacute;ch ph&ograve;ng trống ph&ugrave; hợp với số lượng kh&aacute;ch để tư vấn.&nbsp;</p>
	</li>
</ul>

<p><img src="https://www.pos365.vn/storage/app/media/2022/9/phuc-vu-quan-karaoke/quy-trinh-don-tiep-tai-quan-karaoke-min.jpg" /></p>

<p><em>Quy tr&igrave;nh đ&oacute;n tiếp tại qu&aacute;n karaoke</em></p>

<h3><strong>1.2. Quy tr&igrave;nh phục vụ</strong></h3>

<p>Quy tr&igrave;nh phục vụ kh&aacute;ch h&agrave;ng tại qu&aacute;n karaoke bao gồm c&aacute;c bước:</p>

<ul>
	<li>
	<p>Bước 1: Hướng dẫn, chỉ đường kh&aacute;ch v&agrave;o ph&ograve;ng đ&atilde; chọn.</p>
	</li>
	<li>
	<p>Bước 2: Phục vụ kh&aacute;ch nước uống v&agrave; c&aacute;c m&oacute;n ăn vặt.</p>
	</li>
	<li>
	<p>Bước 3: Chờ kh&aacute;ch h&agrave;ng chọn menu đồ uống để phục vụ.</p>
	</li>
	<li>
	<p>Bước 4: Phục vụ c&aacute;c y&ecirc;u cầu kh&aacute;c của kh&aacute;ch.</p>
	</li>
</ul>

<p><img src="https://www.pos365.vn/storage/app/media/2022/9/phuc-vu-quan-karaoke/quy-trinh-phuc-vu-tai-quan-karaoke-min.jpg" /></p>

<p><em>Quy tr&igrave;nh phục vụ qu&aacute;n karaoke</em></p>

<h3><strong>1.3. Quy tr&igrave;nh thanh to&aacute;n</strong></h3>

<p>Quy tr&igrave;nh thanh to&aacute;n tại qu&aacute;n karaoke bao gồm c&aacute;c bước:</p>

<ul>
	<li>
	<p>Bước 1: Kiểm lại số lượng thức ăn, đồ uống v&agrave; dịch vụ kh&aacute;c.</p>
	</li>
	<li>
	<p>Bước 2: Thu ng&acirc;n in phiếu tạm t&iacute;nh cho kh&aacute;ch.</p>
	</li>
	<li>
	<p>Bước 3: Thu tiền v&agrave; chờ kh&aacute;ch rời ph&ograve;ng để dọn dẹp.</p>
	</li>
</ul>

<p><img src="https://www.pos365.vn/storage/app/media/2022/9/phuc-vu-quan-karaoke/quy-trinh-thanh-toan-tai-quan-karaoke-min.jpg" /></p>

<p><em>Quy tr&igrave;nh thanh to&aacute;n tại qu&aacute;n karaoke</em></p>

<blockquote>
<p><strong><em>Xem th&ecirc;m:&nbsp;</em></strong><a href="https://www.pos365.vn/quan-ly-quan-karaoke-6405.html" target="_blank"><strong><em>C&aacute;ch quản l&yacute; qu&aacute;n Karaoke hiệu quả kh&ocirc;ng lo thất tho&aacute;t</em></strong></a></p>
</blockquote>

<h2><strong>II. Nội quy nh&acirc;n vi&ecirc;n phục vụ qu&aacute;n karaoke</strong></h2>

<p>Ng&agrave;nh kinh doanh dịch vụ qu&aacute;n karaoke cũng sẽ c&oacute; những nội quy, quy định ri&ecirc;ng cho nh&acirc;n vi&ecirc;n để đảm bảo quy tr&igrave;nh l&agrave;m việc chuẩn chỉnh. Vậy nội quy nh&acirc;n vi&ecirc;n qu&aacute;n karaoke sẽ bao gồm những g&igrave;? Tham khảo nội dung b&ecirc;n dưới để &aacute;p dụng cho qu&aacute;n karaoke của m&igrave;nh nh&eacute;!</p>

<h3><strong>2.1. Quy định về thời gian l&agrave;m việc</strong></h3>

<p>C&aacute;c qu&aacute;n karaoke hiện nay thường hoạt động đến 12h đ&ecirc;m, nh&acirc;n vi&ecirc;n sẽ được ph&acirc;n chia l&agrave;m việc theo ca quy định. Th&ocirc;ng thường, mỗi ca sẽ d&agrave;i 8 tiếng theo giờ hoạt động của qu&aacute;n v&agrave; người quản l&yacute; sẽ ph&acirc;n bổ, sắp xếp nh&acirc;n vi&ecirc;n ph&ugrave; hợp.&nbsp;</p>

<p><img src="https://www.pos365.vn/storage/app/media/2022/9/phuc-vu-quan-karaoke/quy-dinh-ve-thoi-gian-lam-viec-min.jpg" /></p>

<p><em>Quy định về thời gian l&agrave;m việc của nh&acirc;n vi&ecirc;n qu&aacute;n karaoke</em></p>

<p>Nh&acirc;n vi&ecirc;n cũng sẽ được nghỉ giữa ca để ăn uống nhằm đảm bảo sức khỏe v&agrave; chất lượng cho cả ca l&agrave;m việc. Mặc d&ugrave; vậy, giờ nghỉ ngơi của nh&acirc;n vi&ecirc;n qu&aacute;n karaoke sẽ linh hoạt, kh&ocirc;ng được cố định như c&aacute;c c&ocirc;ng việc văn ph&ograve;ng. Nh&acirc;n vi&ecirc;n phải chấp h&agrave;nh nghi&ecirc;m chỉnh nội quy về thời gian l&agrave;m việc m&agrave; qu&aacute;n đưa ra.</p>

<h3><strong>2.2. Trang phục, t&aacute;c phong l&agrave;m việc</strong></h3>

<p>Nh&acirc;n vi&ecirc;n mỗi qu&aacute;n karaoke sẽ c&oacute; những thiết kế đồng phục kh&aacute;c nhau để dễ nhận biết. Từ cấp quản l&yacute; đến nh&acirc;n vi&ecirc;n phục vụ, nh&acirc;n vi&ecirc;n thu ng&acirc;n đều phải ăn mặc gọn g&agrave;ng, tươm tất, sạch sẽ k&egrave;m bảng t&ecirc;n v&agrave; vị tr&iacute; c&ocirc;ng việc. Đối với c&aacute;c cấp bậc v&agrave; khu vực l&agrave;m việc kh&aacute;c nhau, đồng phục c&oacute; thể c&oacute; sự kh&aacute;c nhau một v&agrave;i điểm để dễ nhận biết.</p>

<p><img src="https://www.pos365.vn/storage/app/media/2022/9/phuc-vu-quan-karaoke/trang-phuc-tac-phong-lam-viec-cua-nhan-vien-min.jpg" /></p>

<p><em>Quy định về trang phục, t&aacute;c phong l&agrave;m việc của nh&acirc;n vi&ecirc;n qu&aacute;n karaoke</em></p>

<p>D&ugrave; l&agrave; quản l&yacute; hay nh&acirc;n vi&ecirc;n th&igrave; đều phải c&oacute; t&aacute;c phong l&agrave;m việc nhanh nhẹn, gọn g&agrave;ng, chỉn chu. Mỗi ph&ograve;ng h&aacute;t karaoke sẽ c&oacute; tối đa một nh&acirc;n vi&ecirc;n phục vụ để hỗ trợ tốt cho kh&aacute;ch h&agrave;ng với th&aacute;i độ niềm nở, nhiệt t&igrave;nh, &acirc;n cần v&agrave; chu đ&aacute;o.</p>

<h3><strong>2.3. Vệ sinh v&agrave; an to&agrave;n lao động</strong></h3>

<p>Nh&acirc;n vi&ecirc;n phục vụ qu&aacute;n karaoke sẽ được tập huấn về ph&ograve;ng ch&aacute;y chữa ch&aacute;y v&agrave; an to&agrave;n lao động. B&ecirc;n cạnh đ&oacute;, nh&acirc;n vi&ecirc;n cũng sẽ được đ&agrave;o tạo về c&aacute;ch sử dụng c&aacute;c thiết bị, m&aacute;y m&oacute;c cũng như xử l&yacute; c&aacute;c t&igrave;nh huống ph&aacute;t sinh.&nbsp;</p>

<p>Vấn đề dọn dẹp vệ sinh qu&aacute;n karaoke v&agrave; những khu vực xung quanh cũng được ch&uacute; trọng đảm bảo kh&ocirc;ng gian sạch sẽ. Tất cả c&aacute;c khu vực cần được sắp xếp, dọn dẹp ngăn nắp, gọn g&agrave;ng theo định kỳ v&agrave; theo sự ph&acirc;n c&ocirc;ng, sắp xếp của người quản l&yacute;.</p>

<p><img src="https://www.pos365.vn/storage/app/media/2022/9/phuc-vu-quan-karaoke/noi-quy-ve-ve-sinh-va-an-toan-lao-dong-min.jpg" /></p>

<p><em>Nội quy vệ sinh v&agrave; an to&agrave;n lao động</em></p>

<h3><strong>2.4. Bảo quản t&agrave;i sản v&agrave; b&iacute; mật kinh doanh</strong></h3>

<p>Nội quy tiếp theo m&agrave; nh&acirc;n vi&ecirc;n phục vụ qu&aacute;n karaoke cần phải chấp h&agrave;nh đ&oacute; l&agrave; bảo quản t&agrave;i sản v&agrave; b&iacute; mật kinh doanh của qu&aacute;n. Đ&acirc;y l&agrave; tr&aacute;ch nhiệm chung của tất cả nh&acirc;n vi&ecirc;n v&agrave; sẽ được quy định r&otilde; r&agrave;ng trong nội quy.&nbsp;</p>

<p>Trong trường hợp c&oacute; bất kỳ đồ đạc n&agrave;o bị thất lạc hay bị mất th&igrave; nh&acirc;n vi&ecirc;n sẽ c&oacute; tr&aacute;ch nhiệm đưa về bộ phận c&oacute; li&ecirc;n quan để xử l&yacute; kịp thời. Nh&acirc;n sự qu&aacute;n karaoke bắt buộc phải bảo mật th&ocirc;ng tin về c&aacute;c hoạt động của qu&aacute;n bao gồm kế hoạch, chiến lược kinh doanh qu&aacute;n karaoke.</p>

<p><img src="https://www.pos365.vn/storage/app/media/2022/9/phuc-vu-quan-karaoke/bao-quan-tai-san-va-bi-mat-kinh-doanh-quan-karaoke-min.jpg" /></p>

<p><em>Bảo quản t&agrave;i sản v&agrave; b&iacute; mật kinh doanh qu&aacute;n karaoke</em></p>

<h3><strong>2.5. H&igrave;nh thức kỷ luật vi phạm nội quy</strong></h3>

<p>Mỗi qu&aacute;n karaoke sẽ c&oacute; những nội quy nhất định, c&aacute;c nh&acirc;n vi&ecirc;n cần phải được chấp h&agrave;ng nghi&ecirc;m chỉnh để đảm bảo vận h&agrave;nh qu&aacute;n ổn định. Những trường hợp l&agrave;m sai quy định cần phải c&oacute; những h&igrave;nh thức kỷ luật tương ứng.</p>

<p>Đối với những lỗi mắc nhẹ, vi phạm lần đầu th&ocirc;ng thường sẽ chỉ bị nhắc nhở. Nhưng khi phạm lỗi tương tự lần nữa th&igrave; n&ecirc;n c&oacute; h&igrave;nh thức quảng c&aacute;o. C&aacute;c lỗi nghi&ecirc;m trọng v&agrave; c&oacute; &yacute; chống đối, ph&aacute; hoại c&oacute; thể sẽ bị &aacute;p dụng mức phạt cao nhất l&agrave; đuổi việc hoặc đền b&ugrave; thiệt hại nếu c&oacute;.</p>

<p><img src="https://www.pos365.vn/storage/app/media/2022/9/phuc-vu-quan-karaoke/hinh-thuc-ky-luat-va-vi-pham-noi-quy-min.jpg" /></p>

<p><em>H&igrave;nh thức kỷ luật nh&acirc;n vi&ecirc;n vi phạm nội quy</em></p>

<h2><strong>III. Quản l&yacute; qu&aacute;n karaoke hiệu quả bằng phần mềm quản l&yacute; b&aacute;n h&agrave;ng</strong></h2>

<p><a href="https://www.pos365.vn/nganh-nghe/phan-mem-quan-ly-quan-karaoke" target="_blank"><strong>Phần mềm quản l&yacute; qu&aacute;n Karaoke</strong></a>&nbsp;của POS365 gi&uacute;p kiểm so&aacute;t hiệu quả kinh doanh v&agrave; những th&ocirc;ng tin cần thiết như thời gian thu&ecirc; ph&ograve;ng, t&igrave;nh trạng ph&ograve;ng c&ograve;n trống hay đ&atilde; hết. Phần mềm quản l&yacute; Karaoke c&oacute; thể sử dụng được tr&ecirc;n nhiều thiết bị kh&aacute;c nhau như m&aacute;y t&iacute;nh, m&aacute;y t&iacute;nh bảng, điện thoại&hellip; Phần mềm POS365 mang đến cho qu&aacute;n Karaoke những t&iacute;nh năng chuy&ecirc;n dụng như:</p>

<p><strong><em>Quản l&yacute; h&agrave;ng h&oacute;a:</em></strong></p>

<ul>
	<li>
	<p>Quản l&yacute; chi tiết h&agrave;ng h&oacute;a, nguy&ecirc;n liệu chế biến đồ ăn thức uống.</p>
	</li>
	<li>
	<p>B&ecirc;n cạnh đ&oacute; l&agrave; nhiều t&iacute;nh năng kh&aacute;c như cảnh b&aacute;o tồn kho, c&agrave;i đặt định mức tối thiểu.</p>
	</li>
</ul>

<p><strong><em>T&iacute;nh tiền chuẩn x&aacute;c linh hoạt:</em></strong></p>

<ul>
	<li>
	<p>M&agrave;n h&igrave;nh thu ng&acirc;n hiển thị đầy đủ th&ocirc;ng tin ph&ograve;ng trống, đang sử dụng.</p>
	</li>
	<li>
	<p>Hiển thị giờ check in check out.</p>
	</li>
	<li>
	<p>Hỗ trợ c&agrave;i đặt t&iacute;nh tiền mở m&aacute;y.</p>
	</li>
	<li>
	<p>Hỗ trợ linh hoạt l&agrave;m tr&ograve;n giờ thu&ecirc;.</p>
	</li>
	<li>
	<p>Hỗ trợ in h&oacute;a đơn.</p>
	</li>
	<li>
	<p>Mỗi giao dịch đều tự động được lưu tr&ecirc;n hệ thống</p>
	</li>
</ul>

<p><strong><em>Thanh to&aacute;n đa phương thức</em></strong>: Kh&aacute;ch h&agrave;ng c&oacute; thể thanh to&aacute;n qua v&iacute; điện tử, thẻ ng&acirc;n h&agrave;ng, internet banking,..</p>

<p><img src="https://www.pos365.vn/storage/app/media/2022/9/phuc-vu-quan-karaoke/phan-mem-quan-ly-ban-hang-hieu-qua.jpg" /></p>

<p><em>Quản l&yacute; qu&aacute;n karaoke hiệu quả bằng phần mềm quản l&yacute; b&aacute;n h&agrave;ng</em></p>

<p><strong><em>Quản l&yacute; kh&aacute;ch h&agrave;ng:</em></strong></p>

<ul>
	<li>
	<p>Lưu trữ th&ocirc;ng tin kh&aacute;ch h&agrave;ng: Họ t&ecirc;n, tuổi, số điện thoại, địa chỉ.</p>
	</li>
	<li>
	<p>T&iacute;nh năng t&iacute;ch điểm kh&aacute;ch h&agrave;ng</p>
	</li>
	<li>
	<p>Quản l&yacute; c&ocirc;ng nợ</p>
	</li>
</ul>

<p><strong><em>B&aacute;o c&aacute;o thống k&ecirc; chi tiết:</em></strong></p>

<ul>
	<li>
	<p>B&aacute;o c&aacute;o chi tiết theo thời gian thực.</p>
	</li>
	<li>
	<p>Thể hiện theo biểu đồ cột hoặc tr&ograve;n.</p>
	</li>
	<li>
	<p>Hỗ trợ xuất file Excel.</p>
	</li>
</ul>
')
SET IDENTITY_INSERT [dbo].[ThongTin] OFF
GO
SET IDENTITY_INSERT [dbo].[Time] ON 

INSERT [dbo].[Time] ([Id], [TimeStar], [TimeEnd], [Gia]) VALUES (1, CAST(N'17:00:00' AS Time), CAST(N'03:50:00' AS Time), 20000)
SET IDENTITY_INSERT [dbo].[Time] OFF
GO
SET IDENTITY_INSERT [dbo].[TinTuc] ON 

INSERT [dbo].[TinTuc] ([Id], [TieuDe], [NoiDung], [ChucVuId], [Hinhanh], [TrangThai], [Luong], [Ngay], [TrangThaiTin], [Soluong]) VALUES (9, N'<p>Tuyển Nh&acirc;n vi&ecirc;n nữ</p>
', N'<p>Tuyển Nh&acirc;n vi&ecirc;n nữ phục vụ qu&aacute;n karaoke 💕 Karaoke Galaxy Tại Tp Hồ Ch&iacute; Minh Cần tuyển 35 nữ 17-28 ( ngoại h&igrave;nh b&igrave;nh thường ) thu nhập th&aacute;ng tr&ecirc;n 35-40 triệu 💕 Hỗ trở tiền xe t&agrave;u cho nh&acirc;n vi&ecirc;n khi đến xin việc QU&Aacute;N BAO ĂN Ở ☎Li&ecirc;n hệ : Anh Nam ✅✅ Nh&acirc;n vi&ecirc;n l&ecirc;n l&agrave;m kh&oacute; khăn qu&aacute;n sẽ cho ứng tiền trước ✅ C&ocirc;ng việc : Phục vụ r&oacute;t bia gắp đ&aacute; bấm b&agrave;i h&aacute;t cho kh&aacute;ch ( chưa c&oacute; kinh nghiệm sẽ được hướng dẫn v&agrave; đ&agrave;o tạo ) 👉 Kh&ocirc;ng &eacute;p uống bia v&agrave; l&agrave;m việc bậy bạ 💸💸 thu nhập tiền bo b&agrave;n tr&ecirc;n 500k &#39; tiền bo trung b&igrave;nh ng&agrave;y tr&ecirc;n 1-3 triệu lấy tiền lu&ocirc;n trong ng&agrave;y Ngo&agrave;i tiền bo ra c&ograve;n c&oacute; tiền lương thưởng th&aacute;ng 8 Triệu ri&ecirc;ng Đảm bảo thu nhập kh&ocirc;ng dưới 35 triệu th&aacute;ng ⏰ Thời gian l&agrave;m việc 2h chiều -12 tối mệt nghỉ kh&ocirc;ng &eacute;p l&agrave;m th&aacute;ng nghi ph&eacute;p 4 ng&agrave;y ( ngo&agrave;i thời gian l&agrave;m việc ra ngo&agrave;i mua sắm đi chơi tư do ) 🔕🔕CAM ĐOAN ❌ KH&Ocirc;NG PHỤC NHẠY CẢM. ❌ KH&Ocirc;NG LỪA ĐẠO L&Agrave;M G&Aacute;I ❌KH&Ocirc;NG L&Agrave;M TR&Aacute;I PH&Aacute;T LUẬT Qu&aacute;n Bao Ăn Ở ( 2 nh&acirc;n vi&ecirc;n 1 ph&ograve;ng đầy đủ tiện nghi ) 💲- Uy t&iacute;n v&agrave; thấu hiểu mọi nh&acirc;n vi&ecirc;n, tạo m&ocirc;i trường *** cho nh&acirc;n vi&ecirc;n kh&ocirc;ng g&acirc;y &aacute;p lực .🌹 Qu&aacute;n tuyển trực tiếp . Nh&acirc;n vi&ecirc;n kh&ocirc;ng phải đ&oacute;ng tiền khi đến xin việc 🎗️- H&atilde;y gọi điện để được tư vấn kỹ hơn. ☎️ : Anh Nam hỗ trợ Zalo hoặc ibox tại trang</p>
', 3, N'1c45338189ba40c397177f3b2bb8423e.jpg', 1, 4500000, CAST(N'2023-03-18' AS Date), 2, 8)
INSERT [dbo].[TinTuc] ([Id], [TieuDe], [NoiDung], [ChucVuId], [Hinhanh], [TrangThai], [Luong], [Ngay], [TrangThaiTin], [Soluong]) VALUES (11, N'<p>tuyển nh&acirc;n vi&ecirc;n tr&ocirc;ng qu&aacute;n</p>
', N'<p>Tr&ocirc;ng qu&aacute;n v&agrave; phục vụ kh&aacute;c bao ăn ở tại chỗ l&agrave;m</p>

<p><img alt="Hình thức trả lương" src="https://static.chotot.com/storage/icons/logos/ad-param/salary_type.png" /></p>

<p>H&igrave;nh thức trả lương:&nbsp;Theo th&aacute;ng</p>

<p><img alt="Loại công việc" src="https://static.chotot.com/storage/icons/logos/ad-param/contract_type.png" /></p>

<p>Loại c&ocirc;ng việc:&nbsp;B&aacute;n thời gian</p>

<p><img alt="Ngành nghề" src="https://static.chotot.com/storage/icons/logos/ad-param/job_type.png" /></p>

<p>Ng&agrave;nh nghề:&nbsp;C&ocirc;ng việc kh&aacute;c</p>

<p><img alt="Kinh nghiệm" src="https://static.chotot.com/storage/icons/logos/ad-param/preferred_working_experience.png" /></p>

<p>Kinh nghiệm:&nbsp;Kh&ocirc;ng y&ecirc;u cầu</p>

<p><img alt="Giới tính" src="https://static.chotot.com/storage/icons/logos/ad-param/preferred_gender.png" /></p>

<p>Giới t&iacute;nh:&nbsp;Nam</p>

<p><img alt="Tên công ty" src="https://static.chotot.com/storage/icons/logos/ad-param/company_name.png" /></p>

<p>T&ecirc;n c&ocirc;ng ty:&nbsp;th&agrave;nh nam</p>

<p><img alt="Số lượng tuyển dụng" src="https://static.chotot.com/storage/icons/logos/ad-param/vacancies.png" /></p>

<p>Số lượng tuyển dụng:&nbsp;2</p>

<p><img alt="Các quyền lợi khác" src="https://static.chotot.com/storage/icons/logos/ad-param/benefits.png" /></p>

<p>C&aacute;c quyền lợi kh&aacute;c:&nbsp;thưởng si&ecirc;ng năng</p>

<p><img alt="Học vấn tối thiểu" src="https://static.chotot.com/storage/icons/logos/ad-param/preferred_education.png" /></p>

<p>Học vấn tối thiểu:&nbsp;Cấp 1</p>

<p><img alt="Chứng chỉ / kỹ năng" src="https://static.chotot.com/storage/icons/logos/ad-param/skills.png" /></p>

<p>Chứng chỉ / kỹ năng:&nbsp;kh&ocirc;ng y&ecirc;u cầu</p>

<p><img alt="Tuổi tối thiểu" src="https://static.chotot.com/storage/icons/logos/ad-param/min_age.png" /></p>

<p>Tuổi tối thiểu:&nbsp;18</p>

<p><img alt="Tuổi tối đa" src="https://static.chotot.com/storage/icons/logos/ad-param/max_age.png" /></p>

<p>Tuổi tối đa:&nbsp;30</p>
', 3, N'27319c8d5c564e6ea5506c7402371e98.jpg', 1, 4500000, CAST(N'2023-03-18' AS Date), 2, 9)
INSERT [dbo].[TinTuc] ([Id], [TieuDe], [NoiDung], [ChucVuId], [Hinhanh], [TrangThai], [Luong], [Ngay], [TrangThaiTin], [Soluong]) VALUES (12, N'<p>C&aacute;c chương tr&igrave;nh ưu đ&atilde;i th&aacute;ng 6 tại Karaoke&nbsp;</p>
', N'<h3><strong>1. TIỆC T&Ugrave;NG BẤT TẬN &ndash; QU&Agrave; NHẬN LIỀN TAY</strong></h3>

<p><strong>H&oacute;a đơn đặt tiệc từ 5.000.000 &ndash; 7.000.000đ:</strong><br />
► Giảm 10% thực đơn tiệc<br />
► Miễn ph&iacute; 2 giờ h&aacute;t Karaoke<br />
► Miễn ph&iacute; trang tr&iacute; b&agrave;n gallery v&agrave; trang tr&iacute; bong b&oacute;ng</p>

<p><img alt="Các chương trình ưu đãi tháng 6 tại Karaoke Hoàng Triều 1" src="http://hoangtrieu.vn/wp-content/uploads/2022/03/b6f1438aa814654a3c05-1024x768.jpg" style="height:768px; width:1024px" title="Các chương trình ưu đãi tháng 6 tại Karaoke Hoàng Triều 2" /></p>

<p><strong>H&oacute;a đơn đặt tiệc từ 8.000.000 &ndash; 10.000.000đ:</strong><br />
► Giảm 10% thực đơn tiệc<br />
► Miễn ph&iacute; 2 giờ h&aacute;t Karaoke<br />
► Miễn ph&iacute; trang tr&iacute; b&agrave;n gallery v&agrave; trang tr&iacute; bong b&oacute;ng<br />
► Tặng b&aacute;nh kem hoặc set shooter cocktail trong buổi tiệc<br />
► Tặng voucher thanh to&aacute;n 200.000đ khi sử dụng c&aacute;c dịch vụ tại Ho&agrave;ng Triều Entertainment.</p>

<p><img alt="Các chương trình ưu đãi tháng 6 tại Karaoke Hoàng Triều 2" src="http://hoangtrieu.vn/wp-content/uploads/2022/06/278832922_947810292571152_2958697921459477488_n-1024x768.jpg" style="height:768px; width:1024px" title="Các chương trình ưu đãi tháng 6 tại Karaoke Hoàng Triều 3" /></p>

<p><strong>H&oacute;a đơn đặt tiệc từ 11.000.000 &ndash; 15.000.000đ:</strong><br />
► Giảm 15% thực đơn tiệc<br />
► Miễn ph&iacute; 3 giờ h&aacute;t Karaoke<br />
► Miễn ph&iacute; trang tr&iacute; b&agrave;n gallery v&agrave; trang tr&iacute; bong b&oacute;ng<br />
► Tặng b&aacute;nh kem hoặc set shooter cocktail trong buổi tiệc<br />
► Tặng voucher thanh to&aacute;n 500.000đ khi sử dụng c&aacute;c dịch vụ tại Ho&agrave;ng Triều Entertainment.</p>

<p><img alt="Đặt tiệc Karaoke Hoàng Triều" src="http://hoangtrieu.vn/wp-content/uploads/2022/03/IMG_8765-1024x683.jpg" style="height:683px; width:1024px" title="Các chương trình ưu đãi tháng 6 tại Karaoke Hoàng Triều 4" /></p>

<p>*Kh&ocirc;ng cộng dồn ưu đ&atilde;i đặt tiệc c&ugrave;ng c&aacute;c ưu đ&atilde;i kh&aacute;c.</p>

<h3><strong>2. H&Aacute;T 2 GIỜ ĐƯỢC TẶNG 2 GIỜ TIẾP THEO MIỄN PH&Iacute; (10:00 &ndash; 18:00 MỖI NG&Agrave;Y)</strong></h3>

<p>Chương tr&igrave;nh d&agrave;nh cho tất cả c&aacute;c đối tượng kh&aacute;ch h&agrave;ng đến sử dụng dịch vụ Karaoke Ho&agrave;ng Triều trong khung giờ từ 10:00 &ndash; 18:00 hằng ng&agrave;y.</p>

<p><img alt="Các chương trình ưu đãi tháng 6 tại Karaoke Hoàng Triều 3" src="http://hoangtrieu.vn/wp-content/uploads/2022/04/Untitled-1d%C3%A1das-1024x686.jpg" style="height:686px; width:1024px" title="Các chương trình ưu đãi tháng 6 tại Karaoke Hoàng Triều 5" /></p>

<p>*Chương tr&igrave;nh &aacute;p dụng với c&aacute;c ph&ograve;ng loại VIP.<br />
*Kh&ocirc;ng &aacute;p dụng v&agrave;o ng&agrave;y Lễ, Tết v&agrave; kh&ocirc;ng cộng dồn c&ugrave;ng c&aacute;c ưu đ&atilde;i kh&aacute;c.</p>

<h3><strong>3. H&Aacute;T THẢ GA CHỈ 500K D&Agrave;NH CHO HỌC SINH&nbsp; &ndash; SINH VI&Ecirc;N (10:00 &ndash; 18:00 TỪ THỨ 2 ĐẾN THỨ 5)</strong></h3>

<p>Kh&aacute;ch h&agrave;ng l&agrave; Học sinh &ndash; Sinh vi&ecirc;n c&oacute; thể bao ph&ograve;ng VIP để thỏa sức h&aacute;t h&ograve; suốt 8 tiếng chỉ với 500.000đ ph&iacute; giờ h&aacute;t. Kh&aacute;ch h&agrave;ng chỉ cần xuất tr&igrave;nh thẻ Học sinh&nbsp; &ndash; Sinh vi&ecirc;n hợp lệ v&agrave; mỗi người trong nh&oacute;m gọi th&ecirc;m 01 phần nước bất kỳ l&agrave; đủ điều kiện sử dụng g&oacute;i ưu đ&atilde;i d&agrave;nh ri&ecirc;ng cho Học sinh &ndash; Sinh vi&ecirc;n.</p>

<p><img alt="Hát karaoke thả ga từ sáng đến chiều chỉ với 500K" src="http://hoangtrieu.vn/wp-content/uploads/2022/04/58d3616423177-683x1024.jpg" style="height:1024px; width:683px" title="Các chương trình ưu đãi tháng 6 tại Karaoke Hoàng Triều 6" /></p>

<p>*Chương tr&igrave;nh &aacute;p dụng với c&aacute;c ph&ograve;ng loại VIP.<br />
*Kh&ocirc;ng &aacute;p dụng v&agrave;o ng&agrave;y Lễ, Tết v&agrave; kh&ocirc;ng cộng dồn c&ugrave;ng c&aacute;c ưu đ&atilde;i kh&aacute;c.</p>

<h3><strong>4. V&Ograve;NG XOAY MAY MẮN (18:00 &ndash; 0:00 TỪ THỨ 2 ĐẾN THỨ 6)</strong></h3>

<p>Với h&oacute;a đơn sử dụng dịch vụ Karaoke Ho&agrave;ng Triều từ 2.800.000đ, kh&aacute;ch h&agrave;ng sẽ nhận được 01 lượt quay với tỉ lệ tr&uacute;ng thưởng 100%. C&aacute;c phần thưởng sẽ được &aacute;p dụng tại chỗ như:</p>

<p>►Tặng 3 lon bia</p>

<p>►Tặng 1 giờ h&aacute;t</p>

<p>►Tặng 1 đĩa tr&aacute;i c&acirc;y hoặc shisha</p>

<p>►Giảm gi&aacute; 30% giờ h&aacute;t</p>

<p>►Giảm gi&aacute; 50% giờ h&aacute;t</p>

<p>►Giảm gi&aacute; 10% tổng h&oacute;a đơn</p>

<p>&nbsp;</p>

<p><img alt="Các chương trình ưu đãi tháng 6 tại Karaoke Hoàng Triều 4" src="http://hoangtrieu.vn/wp-content/uploads/2022/04/z3306038440403_23d9050d479cd4a3b8cf6db04c40910d-1-1024x576.jpg" style="height:576px; width:1024px" title="Các chương trình ưu đãi tháng 6 tại Karaoke Hoàng Triều 7" /></p>

<p>&nbsp;</p>

<p>*Kh&ocirc;ng cộng dồn c&ugrave;ng c&aacute;c ưu đ&atilde;i kh&aacute;c.</p>

<p>*Phần thưởng kh&aacute;ch quay tr&uacute;ng sẽ được &aacute;p dụng với h&oacute;a đơn trong ng&agrave;y.</p>

<p>&nbsp;</p>

<h3><strong>5. THỨ 5 HẰNG TUẦN | TẶNG 1 M&Oacute;N ĂN CHO NH&Oacute;M KH&Aacute;CH 5 NGƯỜI C&Oacute; BILL TỪ 999.000đ</strong></h3>

<p>Với nh&oacute;m kh&aacute;ch từ 5 người trở l&ecirc;n v&agrave; c&oacute; h&oacute;a đơn sử dụng dịch vụ Karaoke Ho&agrave;ng Triều từ 999.000đ, kh&aacute;ch h&agrave;ng sẽ được tặng 1 trong 4 m&oacute;n tự chọn trong thực đơn mới bao gồm:</p>

<p>►Dồi sụn</p>

<p>►Gỏi xo&agrave;i c&aacute; sặc trứng</p>

<p>►Ch&acirc;n g&agrave; chi&ecirc;n nước mắm</p>

<p>►Răng mực rang muối Hồng K&ocirc;ng</p>

<p>&nbsp;</p>

<p><img alt="Các chương trình ưu đãi tháng 6 tại Karaoke Hoàng Triều 5" src="http://hoangtrieu.vn/wp-content/uploads/2022/04/278530378_5065359920178053_3133278859957964954_n-1024x683.jpg" style="height:683px; width:1024px" title="Các chương trình ưu đãi tháng 6 tại Karaoke Hoàng Triều 8" /></p>

<p><img alt="Các chương trình ưu đãi tháng 6 tại Karaoke Hoàng Triều 6" src="http://hoangtrieu.vn/wp-content/uploads/2022/04/IMG_3206-1024x683.jpg" style="height:683px; width:1024px" title="Các chương trình ưu đãi tháng 6 tại Karaoke Hoàng Triều 9" /></p>

<p>*Kh&ocirc;ng cộng dồn c&ugrave;ng c&aacute;c ưu đ&atilde;i kh&aacute;c.</p>

<h3><strong>6. COMBO TR&Aacute;I C&Acirc;Y DĨA ĐẶC BIỆT V&Agrave; SHISHA CHỈ 600.000đ</strong></h3>

<p>Combo 1 phần tr&aacute;i c&acirc;y dĩa đặc biệt v&agrave; 1 shisha đang c&oacute; gi&aacute; b&aacute;n si&ecirc;u ưu đ&atilde;i chỉ với 600.000đ, tiết kiệm đến 180.000đ so với khi mua lẻ (combo được &aacute;p dụng xuy&ecirc;n suốt mọi khung giờ kể từ ng&agrave;y 17/5).</p>

<p>&nbsp;</p>

<p><img alt="Tổng hợp các ưu đãi tháng 5 tại Karaoke Hoàng Triều 5" src="http://hoangtrieu.vn/wp-content/uploads/2022/05/281903898_5160158320698212_1573445492775680079_n-1-725x1024.jpg" style="height:1024px; width:725px" title="Tổng hợp các ưu đãi tháng 5 tại Karaoke Hoàng Triều 6" /></p>

<p>&nbsp;</p>

<h3><strong>7. COMBO 10 FUNKY BALLOONS GI&Aacute; ƯU Đ&Atilde;I</strong></h3>

<p>►Từ thứ 2 đến thứ 5 hằng tuần, funky balloon tại Karaoke Ho&agrave;ng Triều c&oacute; gi&aacute; b&aacute;n mới chỉ 150.000đ/quả.</p>

<p><img alt="Các chương trình ưu đãi tháng 6 tại Karaoke Hoàng Triều 7" src="http://hoangtrieu.vn/wp-content/uploads/2022/05/282000191_5160231484024229_1546074354487546522_n-1-589x1024.jpg" style="height:1024px; width:589px" title="Các chương trình ưu đãi tháng 6 tại Karaoke Hoàng Triều 10" /><br />
►Từ thứ 6 đến Chủ Nhật hằng tuần, funky balloon c&oacute; gi&aacute; 180.000đ/quả. Đặc biệt, khi mua combo 10 quả th&igrave; kh&aacute;ch h&agrave;ng sẽ được gi&aacute; ưu đ&atilde;i hơn chỉ c&ograve;n 150.000đ/quả.</p>

<h3><strong>8. TẶNG VOUCHER GIẢM GI&Aacute; KHI ĐẶT PH&Ograve;NG KH&Aacute;CH SẠN HO&Agrave;NG TRIỀU</strong></h3>

<p>►H&oacute;a đơn Karaoke 3.500.000đ: Tặng 01 voucher kh&aacute;ch sạn giảm 10% gi&aacute; ph&ograve;ng</p>

<p>►H&oacute;a đơn Karaoke 4.500.000đ: Tặng 01 voucher kh&aacute;ch sạn giảm 15% gi&aacute; ph&ograve;ng</p>

<p>►H&oacute;a đơn Karaoke 5.500.000đ: Tặng 01 voucher kh&aacute;ch sạn giảm 20% gi&aacute; ph&ograve;ng</p>

<p>&nbsp;</p>

<p><img alt="Các chương trình ưu đãi tháng 6 tại Karaoke Hoàng Triều 8" src="http://hoangtrieu.vn/wp-content/uploads/2022/04/hinhpost-fb-04-1024x686.jpg" style="height:686px; width:1024px" title="Các chương trình ưu đãi tháng 6 tại Karaoke Hoàng Triều 11" /></p>

<p>&nbsp;</p>

<p>*Voucher kh&aacute;ch sạn c&oacute; gi&aacute; trị 07 ng&agrave;y kể từ ng&agrave;y nhận.</p>

<p>&nbsp;</p>

<p>&nbsp;</p>
', NULL, N'163ea2d4adea43f997b249a6a2322c14.jpg', 1, NULL, CAST(N'2023-03-18' AS Date), 1, NULL)
INSERT [dbo].[TinTuc] ([Id], [TieuDe], [NoiDung], [ChucVuId], [Hinhanh], [TrangThai], [Luong], [Ngay], [TrangThaiTin], [Soluong]) VALUES (13, N'<p>abc</p>
', N'<p>abc</p>
', NULL, N'be993d2cb07f4a8b87c76745e8b0dee9.jpg', 1, NULL, CAST(N'2023-03-19' AS Date), 1, NULL)
SET IDENTITY_INSERT [dbo].[TinTuc] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UC_Email]    Script Date: 04/25/2023 10:59:31 AM ******/
ALTER TABLE [dbo].[KhachHangg] ADD  CONSTRAINT [UC_Email] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ChucVu] ADD  CONSTRAINT [DF_ChucVu_NgayCapNhat]  DEFAULT (getdate()) FOR [NgayCapNhat]
GO
ALTER TABLE [dbo].[DonViTinh] ADD  CONSTRAINT [DF_DonViTinh_NgayCapNhat]  DEFAULT (getdate()) FOR [NgayCapNhat]
GO
ALTER TABLE [dbo].[KhoHang] ADD  CONSTRAINT [DF_KhoHang_NgayCapNhat]  DEFAULT (getdate()) FOR [NgayCapNhat]
GO
ALTER TABLE [dbo].[LienHe] ADD  CONSTRAINT [DF_LienHe_TrangThai]  DEFAULT ((0)) FOR [TrangThai]
GO
ALTER TABLE [dbo].[LienHe] ADD  CONSTRAINT [DF_LienHe_NgayLH]  DEFAULT (getdate()) FOR [NgayLH]
GO
ALTER TABLE [dbo].[LoaiPhong] ADD  CONSTRAINT [DF_LoaiPhong_NgayCapNhat]  DEFAULT (getdate()) FOR [NgayCapNhat]
GO
ALTER TABLE [dbo].[Phong] ADD  CONSTRAINT [DF_Phong_TrangThai]  DEFAULT ((1)) FOR [TrangThai]
GO
ALTER TABLE [dbo].[CTKhoHang]  WITH CHECK ADD  CONSTRAINT [FK_CTKhoHang_KhoHang] FOREIGN KEY([IdKh])
REFERENCES [dbo].[KhoHang] ([IDMatHang])
GO
ALTER TABLE [dbo].[CTKhoHang] CHECK CONSTRAINT [FK_CTKhoHang_KhoHang]
GO
ALTER TABLE [dbo].[DatPhong]  WITH CHECK ADD  CONSTRAINT [FK_DatPhong_DaysOfWeeks] FOREIGN KEY([IdDate])
REFERENCES [dbo].[DaysOfWeeks] ([ID])
GO
ALTER TABLE [dbo].[DatPhong] CHECK CONSTRAINT [FK_DatPhong_DaysOfWeeks]
GO
ALTER TABLE [dbo].[DatPhong]  WITH CHECK ADD  CONSTRAINT [FK_DatPhong_GiammGia] FOREIGN KEY([IdGG])
REFERENCES [dbo].[GiammGia] ([IdGG])
GO
ALTER TABLE [dbo].[DatPhong] CHECK CONSTRAINT [FK_DatPhong_GiammGia]
GO
ALTER TABLE [dbo].[DatPhong]  WITH CHECK ADD  CONSTRAINT [FK_DatPhong_KhachHangg] FOREIGN KEY([IdKH])
REFERENCES [dbo].[KhachHangg] ([ID])
GO
ALTER TABLE [dbo].[DatPhong] CHECK CONSTRAINT [FK_DatPhong_KhachHangg]
GO
ALTER TABLE [dbo].[DatPhong]  WITH CHECK ADD  CONSTRAINT [FK_DatPhong_LichDatP] FOREIGN KEY([IdLich])
REFERENCES [dbo].[LichDatP] ([Id])
GO
ALTER TABLE [dbo].[DatPhong] CHECK CONSTRAINT [FK_DatPhong_LichDatP]
GO
ALTER TABLE [dbo].[DatPhong]  WITH CHECK ADD  CONSTRAINT [FK_DatPhong_LoaiPhong] FOREIGN KEY([IdLoai])
REFERENCES [dbo].[LoaiPhong] ([IDLoaiPhong])
GO
ALTER TABLE [dbo].[DatPhong] CHECK CONSTRAINT [FK_DatPhong_LoaiPhong]
GO
ALTER TABLE [dbo].[DatPhong]  WITH CHECK ADD  CONSTRAINT [FK_DatPhong_Phong] FOREIGN KEY([IdPhong])
REFERENCES [dbo].[Phong] ([IDPhong])
GO
ALTER TABLE [dbo].[DatPhong] CHECK CONSTRAINT [FK_DatPhong_Phong]
GO
ALTER TABLE [dbo].[DatPhong]  WITH CHECK ADD  CONSTRAINT [FK_DatPhong_Time] FOREIGN KEY([IdTime])
REFERENCES [dbo].[Time] ([Id])
GO
ALTER TABLE [dbo].[DatPhong] CHECK CONSTRAINT [FK_DatPhong_Time]
GO
ALTER TABLE [dbo].[DichVu1]  WITH CHECK ADD  CONSTRAINT [FK_DichVu1_DonViTinh] FOREIGN KEY([IDDVT])
REFERENCES [dbo].[DonViTinh] ([IDDonVT])
GO
ALTER TABLE [dbo].[DichVu1] CHECK CONSTRAINT [FK_DichVu1_DonViTinh]
GO
ALTER TABLE [dbo].[DichVu1]  WITH CHECK ADD  CONSTRAINT [FK_DichVu1_KhoHang] FOREIGN KEY([IDKhoHang])
REFERENCES [dbo].[KhoHang] ([IDMatHang])
GO
ALTER TABLE [dbo].[DichVu1] CHECK CONSTRAINT [FK_DichVu1_KhoHang]
GO
ALTER TABLE [dbo].[DichVu1]  WITH CHECK ADD  CONSTRAINT [FK_DichVu1_LoaiDV] FOREIGN KEY([IdLoai])
REFERENCES [dbo].[LoaiDV] ([ID])
GO
ALTER TABLE [dbo].[DichVu1] CHECK CONSTRAINT [FK_DichVu1_LoaiDV]
GO
ALTER TABLE [dbo].[GiammGia]  WITH CHECK ADD  CONSTRAINT [FK_GiammGia_KhachHangg] FOREIGN KEY([Idk])
REFERENCES [dbo].[KhachHangg] ([ID])
GO
ALTER TABLE [dbo].[GiammGia] CHECK CONSTRAINT [FK_GiammGia_KhachHangg]
GO
ALTER TABLE [dbo].[HOADON]  WITH CHECK ADD  CONSTRAINT [FK_HOADON_DatPhong1] FOREIGN KEY([IDDatPhong])
REFERENCES [dbo].[DatPhong] ([Id])
GO
ALTER TABLE [dbo].[HOADON] CHECK CONSTRAINT [FK_HOADON_DatPhong1]
GO
ALTER TABLE [dbo].[HOADON]  WITH CHECK ADD  CONSTRAINT [FK_HOADON_SuDungDichVu] FOREIGN KEY([IdSDDV])
REFERENCES [dbo].[SuDungDichVu] ([ID])
GO
ALTER TABLE [dbo].[HOADON] CHECK CONSTRAINT [FK_HOADON_SuDungDichVu]
GO
ALTER TABLE [dbo].[KhoHang]  WITH CHECK ADD  CONSTRAINT [FK_KhoHang_DonViTinh] FOREIGN KEY([IDDonVT])
REFERENCES [dbo].[DonViTinh] ([IDDonVT])
GO
ALTER TABLE [dbo].[KhoHang] CHECK CONSTRAINT [FK_KhoHang_DonViTinh]
GO
ALTER TABLE [dbo].[KhoHang]  WITH CHECK ADD  CONSTRAINT [FK_KhoHang_LoaiDV] FOREIGN KEY([LoaiDv])
REFERENCES [dbo].[LoaiDV] ([ID])
GO
ALTER TABLE [dbo].[KhoHang] CHECK CONSTRAINT [FK_KhoHang_LoaiDV]
GO
ALTER TABLE [dbo].[LichDatP]  WITH CHECK ADD  CONSTRAINT [FK_LichDatP_DaysOfWeeks] FOREIGN KEY([IdDate])
REFERENCES [dbo].[DaysOfWeeks] ([ID])
GO
ALTER TABLE [dbo].[LichDatP] CHECK CONSTRAINT [FK_LichDatP_DaysOfWeeks]
GO
ALTER TABLE [dbo].[LichDatP]  WITH CHECK ADD  CONSTRAINT [FK_LichDatP_KhachHangg] FOREIGN KEY([IdKh])
REFERENCES [dbo].[KhachHangg] ([ID])
GO
ALTER TABLE [dbo].[LichDatP] CHECK CONSTRAINT [FK_LichDatP_KhachHangg]
GO
ALTER TABLE [dbo].[LichDatP]  WITH CHECK ADD  CONSTRAINT [FK_LichDatP_KhachHangg1] FOREIGN KEY([IdKh])
REFERENCES [dbo].[KhachHangg] ([ID])
GO
ALTER TABLE [dbo].[LichDatP] CHECK CONSTRAINT [FK_LichDatP_KhachHangg1]
GO
ALTER TABLE [dbo].[LichDatP]  WITH CHECK ADD  CONSTRAINT [FK_LichDatP_LoaiPhong] FOREIGN KEY([IdLoai])
REFERENCES [dbo].[LoaiPhong] ([IDLoaiPhong])
GO
ALTER TABLE [dbo].[LichDatP] CHECK CONSTRAINT [FK_LichDatP_LoaiPhong]
GO
ALTER TABLE [dbo].[LichDatP]  WITH CHECK ADD  CONSTRAINT [FK_LichDatP_Phong] FOREIGN KEY([IdPhong])
REFERENCES [dbo].[Phong] ([IDPhong])
GO
ALTER TABLE [dbo].[LichDatP] CHECK CONSTRAINT [FK_LichDatP_Phong]
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD  CONSTRAINT [FK_NhanVien_ChucVu] FOREIGN KEY([IDChucVu])
REFERENCES [dbo].[ChucVu] ([IDChucVu])
GO
ALTER TABLE [dbo].[NhanVien] CHECK CONSTRAINT [FK_NhanVien_ChucVu]
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD  CONSTRAINT [FK_NhanVien_KhachHangg] FOREIGN KEY([IdKh])
REFERENCES [dbo].[KhachHangg] ([ID])
GO
ALTER TABLE [dbo].[NhanVien] CHECK CONSTRAINT [FK_NhanVien_KhachHangg]
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD  CONSTRAINT [FK_NhanVien_TinTuc] FOREIGN KEY([IdTin])
REFERENCES [dbo].[TinTuc] ([Id])
GO
ALTER TABLE [dbo].[NhanVien] CHECK CONSTRAINT [FK_NhanVien_TinTuc]
GO
ALTER TABLE [dbo].[Phong]  WITH CHECK ADD  CONSTRAINT [FK_Phong_LoaiPhong] FOREIGN KEY([IDLoaiPhong])
REFERENCES [dbo].[LoaiPhong] ([IDLoaiPhong])
GO
ALTER TABLE [dbo].[Phong] CHECK CONSTRAINT [FK_Phong_LoaiPhong]
GO
ALTER TABLE [dbo].[SuDungDichVu]  WITH CHECK ADD  CONSTRAINT [FK_GioHang_DichVu1] FOREIGN KEY([IDDv])
REFERENCES [dbo].[DichVu1] ([IDDichVu])
GO
ALTER TABLE [dbo].[SuDungDichVu] CHECK CONSTRAINT [FK_GioHang_DichVu1]
GO
ALTER TABLE [dbo].[SuDungDichVu]  WITH CHECK ADD  CONSTRAINT [FK_SuDungDichVu_DatPhong] FOREIGN KEY([IdDP])
REFERENCES [dbo].[DatPhong] ([Id])
GO
ALTER TABLE [dbo].[SuDungDichVu] CHECK CONSTRAINT [FK_SuDungDichVu_DatPhong]
GO
ALTER TABLE [dbo].[SuDungDichVu]  WITH CHECK ADD  CONSTRAINT [FK_SuDungDichVu_KhachHangg] FOREIGN KEY([Idkh])
REFERENCES [dbo].[KhachHangg] ([ID])
GO
ALTER TABLE [dbo].[SuDungDichVu] CHECK CONSTRAINT [FK_SuDungDichVu_KhachHangg]
GO
ALTER TABLE [dbo].[TinTuc]  WITH CHECK ADD  CONSTRAINT [FK_TinTuc_ChucVu] FOREIGN KEY([ChucVuId])
REFERENCES [dbo].[ChucVu] ([IDChucVu])
GO
ALTER TABLE [dbo].[TinTuc] CHECK CONSTRAINT [FK_TinTuc_ChucVu]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'getdate()' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Phong', @level2type=N'COLUMN',@level2name=N'NgayTao'
GO
USE [master]
GO
ALTER DATABASE [QLKARAOKE] SET  READ_WRITE 
GO
