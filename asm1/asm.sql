-- Chọn database master
USE master;

-- Tạo database PolyOENEWS
IF DB_ID('PolyOENEWS') IS NULL
    CREATE DATABASE PolyOENEWS;
GO

-- Sử dụng database mới tạo
USE PolyOENEWS;
GO

-- =====================
-- Tạo bảng Logs
-- =====================
CREATE TABLE Logs(
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Urls VARCHAR(MAX) NOT NULL,
    Times DATETIME NOT NULL,
    UserName NVARCHAR(255)
);
GO

-- =====================
-- Tạo bảng Users
-- =====================
CREATE TABLE Users (
    Id NVARCHAR(255) PRIMARY KEY,
    Password NVARCHAR(255),
    Email NVARCHAR(255) UNIQUE,
    Fullname NVARCHAR(255),
    Admin BIT
);
GO

-- =====================
-- Tạo bảng Video
-- =====================
CREATE TABLE Video (
    Id NVARCHAR(255) PRIMARY KEY,
    Title NVARCHAR(255),
    Poster NVARCHAR(255),
    Views INT,
    Description NVARCHAR(255),
    Active BIT
);
GO

-- =====================
-- Tạo bảng Favorite
-- =====================
CREATE TABLE Favorite (
    Id INT PRIMARY KEY IDENTITY,
    UserId NVARCHAR(255),
    VideoId NVARCHAR(255),
    LikeDate DATE,
    FOREIGN KEY (UserId) REFERENCES Users(Id),
    FOREIGN KEY (VideoId) REFERENCES Video(Id)
);
GO

-- =====================
-- Tạo bảng Share
-- =====================
CREATE TABLE Share (
    Id INT PRIMARY KEY IDENTITY,
    UserId NVARCHAR(255),
    VideoId NVARCHAR(255),
    Emails NVARCHAR(255),
    ShareDate DATE,
    FOREIGN KEY (UserId) REFERENCES Users(Id),
    FOREIGN KEY (VideoId) REFERENCES Video(Id)
);
GO

-- =====================
-- Chèn dữ liệu vào Users
-- =====================
INSERT INTO Users (Id, Password, Email, Fullname, Admin) VALUES
('admin01', 'pass123', 'user01@example.com', N'Nguyễn Văn A', 1),
('abc02', 'pass234', 'user02@example.com', N'Trần Thị B', 0),
('nehe03', 'pass345', 'user03@example.com', N'Lê Văn C', 1),
('jere04', 'pass456', 'user04@example.com', N'Phạm Thị D', 0),
('jonh05', 'pass567', 'user05@example.com', N'Hoàng Văn E', 0);
GO

-- =====================
-- Chèn dữ liệu vào Video
-- =====================
INSERT INTO Video (Id, Title, Poster, Views, Description, Active) VALUES
('vid01', N'Hướng dẫn học SQL', 'GDVNkenmIHU', 120, N'Video hướng dẫn SQL cơ bản', 1),
('vid02', N'Lập trình Java cơ bản', '7L0RLrfrBHE', 200, N'Khóa học Java dành cho người mới', 1),
('vid03', N'(DailyStream) RAMBO TÂM SỰ CÙNG ANH HAI BOI VÀ CÂU CHUYỆN MUÔN THỦA', 'pFJ4r0KtOE', 75, N'(DailyStream) RAMBO TÂM SỰ CÙNG ANH HAI BOI VÀ CÂU CHUYỆN MUÔN THỦA', 1),
('vid04', N'Du lịch bằng nhà di động ở Châu Âu P2: Từ Đức qua Áo ghé lâu đài gần ngàn năm tuổi', '2jMScyTJVng', 320, N'Du lịch bằng nhà di động ở Châu Âu P2: Từ Đức qua Áo ghé lâu đài gần ngàn năm tuổi', 1),
('vid05', N'[Review Phim] Khi Bà Ngoại Chơi Bùa Con Cháu Phải Lãnh Lấy Hậu Quả', '0KmFjcsKd84', 150, N'[Review Phim] Khi Bà Ngoại Chơi Bùa Con Cháu Phải Lãnh Lấy Hậu Quả', 1);
GO

-- =====================
-- Chèn dữ liệu vào Favorite
-- =====================
INSERT INTO Favorite (UserId, VideoId, LikeDate) VALUES
('admin01', 'vid01', GETDATE()),
('abc02', 'vid02', GETDATE()),
('nehe03', 'vid03', GETDATE()),
('jere04', 'vid04', GETDATE()),
('jonh05', 'vid05', GETDATE());
GO

-- =====================
-- Chèn dữ liệu vào Share
-- =====================
INSERT INTO Share (UserId, VideoId, Emails, ShareDate) VALUES
('admin01', 'vid01', 'friend1@example.com', GETDATE()),
('abc02', 'vid02', 'friend2@example.com', GETDATE()),
('nehe03', 'vid03', 'friend3@example.com', GETDATE()),
('admin01', 'vid04', 'friend4@example.com', GETDATE()),
('jere04', 'vid05', 'friend5@example.com', GETDATE());
GO


-- Top 10 video được like nhiều nhất
SELECT TOP 10 v.Id, v.Title, COUNT(f.VideoId) AS SoLike
FROM Video v
INNER JOIN Favorite f ON v.Id = f.VideoId
GROUP BY v.Id, v.Title
ORDER BY SoLike DESC;
