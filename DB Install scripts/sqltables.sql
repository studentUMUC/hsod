/****** Object:  Table [dbo].[UserProfile]    Script Date: 04/19/2014 20:16:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserProfile](
	[userName] [nvarchar](256) NOT NULL,
	[firstName] [varchar](50) NULL,
	[lastName] [varchar](50) NULL,
	[middleInitial] [varchar](1) NULL,
	[gender] [char](1) NOT NULL,
	[DOB] [datetime] NULL,
 CONSTRAINT [PK_UserProfile] PRIMARY KEY CLUSTERED 
(
	[userName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Distance]    Script Date: 04/19/2014 20:16:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Distance](
	[distance] [varchar](6) NOT NULL,
	[iDistance] [int] NOT NULL,
 CONSTRAINT [PK_Distance] PRIMARY KEY CLUSTERED 
(
	[distance] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Stroke]    Script Date: 04/19/2014 20:16:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Stroke](
	[strokeCode] [char](2) NOT NULL,
	[strokeName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Stroke] PRIMARY KEY CLUSTERED 
(
	[strokeCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[EventV]    Script Date: 04/19/2014 20:16:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[EventV]
AS
SELECT     dbo.Distance.distance, dbo.Stroke.strokeCode, dbo.Distance.iDistance, dbo.Stroke.strokeName
FROM         dbo.Distance CROSS JOIN
                      dbo.Stroke
GROUP BY dbo.Distance.distance, dbo.Stroke.strokeCode, dbo.Distance.iDistance, dbo.Stroke.strokeName
GO

/****** Object:  Table [dbo].[UserGoal]    Script Date: 04/19/2014 20:16:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserGoal](
	[userName] [nvarchar](256) NOT NULL,
	[strokeCode] [char](2) NOT NULL,
	[distance] [varchar](6) NOT NULL,
	[goalTime] [time](2) NOT NULL,
 CONSTRAINT [PK_UserGoal] PRIMARY KEY CLUSTERED 
(
	[userName] ASC,
	[strokeCode] ASC,
	[distance] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserResult]    Script Date: 04/19/2014 20:16:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserResult](
	[userName] [nvarchar](256) NOT NULL,
	[strokeCode] [char](2) NOT NULL,
	[distance] [varchar](6) NOT NULL,
	[resultTime] [time](2) NOT NULL,
	[resultDate] [datetime] NOT NULL,
 CONSTRAINT [PK_UserResult] PRIMARY KEY CLUSTERED 
(
	[userName] ASC,
	[strokeCode] ASC,
	[distance] ASC,
	[resultDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateGoal]    Script Date: 04/19/2014 20:16:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_UpdateGoal] 
	-- Add the parameters for the stored procedure here
	@userName nvarchar(256),
	@strokeCode char(2),
	@distance varchar(6),
	@time varchar(11)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	

	UPDATE dbo.UserGoal SET  goalTime = @time
	WHERE ((userName = @userName) AND (strokeCode = @strokeCode) AND (distance = @distance))
	
	IF @@ROWCOUNT = 0
		INSERT INTO UserGoal(userName, strokeCode, distance, goalTime)
					VALUES     (@userName, @strokeCode, @distance, @time)
END
GO
/****** Object:  Default [DF_UserProfile_gender]    Script Date: 04/19/2014 20:16:42 ******/
ALTER TABLE [dbo].[UserProfile] ADD  CONSTRAINT [DF_UserProfile_gender]  DEFAULT ('s') FOR [gender]
GO
/****** Object:  ForeignKey [FK_UserGoal_Distance]    Script Date: 04/19/2014 20:16:42 ******/
ALTER TABLE [dbo].[UserGoal]  WITH CHECK ADD  CONSTRAINT [FK_UserGoal_Distance] FOREIGN KEY([distance])
REFERENCES [dbo].[Distance] ([distance])
GO
ALTER TABLE [dbo].[UserGoal] CHECK CONSTRAINT [FK_UserGoal_Distance]
GO
/****** Object:  ForeignKey [FK_UserGoal_Stroke]    Script Date: 04/19/2014 20:16:42 ******/
ALTER TABLE [dbo].[UserGoal]  WITH CHECK ADD  CONSTRAINT [FK_UserGoal_Stroke] FOREIGN KEY([strokeCode])
REFERENCES [dbo].[Stroke] ([strokeCode])
GO
ALTER TABLE [dbo].[UserGoal] CHECK CONSTRAINT [FK_UserGoal_Stroke]
GO
/****** Object:  ForeignKey [FK_UserGoal_UserProfile]    Script Date: 04/19/2014 20:16:42 ******/
ALTER TABLE [dbo].[UserGoal]  WITH CHECK ADD  CONSTRAINT [FK_UserGoal_UserProfile] FOREIGN KEY([userName])
REFERENCES [dbo].[UserProfile] ([userName])
GO
ALTER TABLE [dbo].[UserGoal] CHECK CONSTRAINT [FK_UserGoal_UserProfile]
GO
/****** Object:  ForeignKey [FK_UserResult_Distance]    Script Date: 04/19/2014 20:16:42 ******/
ALTER TABLE [dbo].[UserResult]  WITH CHECK ADD  CONSTRAINT [FK_UserResult_Distance] FOREIGN KEY([distance])
REFERENCES [dbo].[Distance] ([distance])
GO
ALTER TABLE [dbo].[UserResult] CHECK CONSTRAINT [FK_UserResult_Distance]
GO
/****** Object:  ForeignKey [FK_UserResult_Stroke]    Script Date: 04/19/2014 20:16:42 ******/
ALTER TABLE [dbo].[UserResult]  WITH CHECK ADD  CONSTRAINT [FK_UserResult_Stroke] FOREIGN KEY([strokeCode])
REFERENCES [dbo].[Stroke] ([strokeCode])
GO
ALTER TABLE [dbo].[UserResult] CHECK CONSTRAINT [FK_UserResult_Stroke]
GO
/****** Object:  ForeignKey [FK_UserResult_UserProfile]    Script Date: 04/19/2014 20:16:42 ******/
ALTER TABLE [dbo].[UserResult]  WITH CHECK ADD  CONSTRAINT [FK_UserResult_UserProfile] FOREIGN KEY([userName])
REFERENCES [dbo].[UserProfile] ([userName])
GO
ALTER TABLE [dbo].[UserResult] CHECK CONSTRAINT [FK_UserResult_UserProfile]
GO

/*------------INSERT DEFAULT TABLE VALUES--------------------*/
INSERT [dbo].[Stroke] ([strokeCode], [strokeName]) VALUES (N'BA', N'Back Stroke')
INSERT [dbo].[Stroke] ([strokeCode], [strokeName]) VALUES (N'BF', N'Butterfly Stroke')
INSERT [dbo].[Stroke] ([strokeCode], [strokeName]) VALUES (N'BR', N'Breast Stroke')
INSERT [dbo].[Stroke] ([strokeCode], [strokeName]) VALUES (N'FS', N'Free Style')
INSERT [dbo].[Stroke] ([strokeCode], [strokeName]) VALUES (N'IM', N'Individual Medley')
INSERT [dbo].[Stroke] ([strokeCode], [strokeName]) VALUES (N'RM', N'Relay Medley')

INSERT [dbo].[Distance] ([distance], [iDistance]) VALUES (N'100y', 100)
INSERT [dbo].[Distance] ([distance], [iDistance]) VALUES (N'200y', 200)
INSERT [dbo].[Distance] ([distance], [iDistance]) VALUES (N'25y', 25)
INSERT [dbo].[Distance] ([distance], [iDistance]) VALUES (N'50y', 50)