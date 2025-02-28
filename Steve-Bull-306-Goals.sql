-- Select all records
SELECT *
  FROM [Steve Bull 306].[dbo].[Steve-Bull-306]

    -- Update our columns with our preferred naming conventions
  
  sp_rename '[Steve Bull 306].[dbo].[Steve-Bull-306].Date', 'date', 'COLUMN';
  sp_rename '[Steve Bull 306].[dbo].[Steve-Bull-306].Season', 'season', 'COLUMN';
  sp_rename '[Steve Bull 306].[dbo].[Steve-Bull-306].Competition', 'competition', 'COLUMN';
  sp_rename '[Steve Bull 306].[dbo].[Steve-Bull-306].H_A', 'home_or_away', 'COLUMN';
  sp_rename '[Steve Bull 306].[dbo].[Steve-Bull-306].W_D_L', 'win_draw_lose', 'COLUMN';
  sp_rename '[Steve Bull 306].[dbo].[Steve-Bull-306].Opponent', 'opponent', 'COLUMN';
  sp_rename '[Steve Bull 306].[dbo].[Steve-Bull-306].Result', 'match_result', 'COLUMN';
  sp_rename '[Steve Bull 306].[dbo].[Steve-Bull-306].Number_of_Goals', 'goals_scored', 'COLUMN';
  sp_rename '[Steve Bull 306].[dbo].[Steve-Bull-306].Attendance', 'attendance', 'COLUMN';
  sp_rename '[Steve Bull 306].[dbo].[Steve-Bull-306].Game_Num', 'game_id', 'COLUMN';
  sp_rename '[Steve Bull 306].[dbo].[Steve-Bull-306].Radius', 'radius', 'COLUMN';

  --Remove columns we don't need
  
  ALTER TABLE [Steve Bull 306].[dbo].[Steve-Bull-306] DROP COLUMN Game_Order;

  -- Check the number of goals scored

  SELECT 
   SUM(goals_scored) AS total_goals
   	 FROM [Steve Bull 306].[dbo].[Steve-Bull-306];

   -- Select all the games where Bully scored in a 1-0 win for Wolves

	SELECT
	 COUNT(*) AS one_nil_win

	 FROM [Steve Bull 306].[dbo].[Steve-Bull-306]

	 WHERE (match_result = '1-0') OR (match_result = '0-1');

  -- Number of goals scored across different match results (W/D/L)

    SELECT 
    win_draw_lose,
     SUM(goals_scored) AS total_goals,
     ROUND(100.0 * SUM(goals_scored) / (SELECT SUM(goals_scored) FROM [Steve Bull 306].[dbo].[Steve-Bull-306]), 2) AS percentage_of_goals

  FROM [Steve Bull 306].[dbo].[Steve-Bull-306]
  GROUP BY win_draw_lose
  ORDER BY total_goals DESC;

   -- Number of goals scored across different seasons (1986-1999)

    SELECT 
    season,
     SUM(goals_scored) AS total_goals,
     ROUND(100.0 * SUM(goals_scored) / (SELECT SUM(goals_scored) FROM [Steve Bull 306].[dbo].[Steve-Bull-306]), 2) AS percentage_of_goals

  FROM [Steve Bull 306].[dbo].[Steve-Bull-306]
  GROUP BY season
  ORDER BY total_goals DESC;

  -- Number of goals scored in each game (singles vs braces vs hat-tricks)

  SELECT 
	  CASE 
        WHEN goals_scored = '1' THEN 'Single goal'
		WHEN goals_scored = '2' THEN 'Brace'
		WHEN goals_scored = '3' THEN 'Hat-Trick'
        ELSE 'Four goals'
     END AS amount_of_goals,
	 COUNT(goals_scored) AS goals_per_match,
     ROUND(100.0 * SUM(goals_scored) / (SELECT SUM(goals_scored) FROM [Steve Bull 306].[dbo].[Steve-Bull-306]), 2) AS percentage_of_goals

  FROM [Steve Bull 306].[dbo].[Steve-Bull-306]
  GROUP BY goals_scored
  ORDER BY goals_per_match DESC;

 -- Number and percentage of Bully's goals scored in home and away matches

  SELECT 
	  CASE 
        WHEN home_or_away = 'H' THEN 'Home'
        ELSE 'Away'
     END
    home_or_away,
     SUM(goals_scored) AS total_goals,
     ROUND(100.0 * SUM(goals_scored) / (SELECT SUM(goals_scored) FROM [Steve Bull 306].[dbo].[Steve-Bull-306]), 2) AS percentage_of_goals

  FROM [Steve Bull 306].[dbo].[Steve-Bull-306]
  GROUP BY home_or_away
  ORDER BY home_or_away DESC;


  -- Number and percentage of Bully's goals scored in league vs cup matches

SELECT 
    CASE 
        WHEN competition LIKE '%division%' THEN 'League'
        ELSE 'Cups/Playoffs'
    END AS competition_category,
    COUNT(*) AS total_games, -- Total number of matches
    SUM(goals_scored) AS total_goals, -- Total goals scored
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM [Steve Bull 306].[dbo].[Steve-Bull-306]), 2) AS game_percentage,
    ROUND(100.0 * SUM(goals_scored) / (SELECT SUM(goals_scored) FROM [Steve Bull 306].[dbo].[Steve-Bull-306]), 2) AS goal_percentage
FROM [Steve Bull 306].[dbo].[Steve-Bull-306]
GROUP BY 
    CASE 
        WHEN competition LIKE '%division%' THEN 'League'
        ELSE 'Cups/Playoffs'
    END
ORDER BY total_goals DESC;

-- Number and percentage of Bully's goals scored in different competitions

  SELECT 
    competition,
     SUM(goals_scored) AS total_goals,
     ROUND(100.0 * SUM(goals_scored) / (SELECT SUM(goals_scored) FROM [Steve Bull 306].[dbo].[Steve-Bull-306]), 2) AS percentage_of_goals

  FROM [Steve Bull 306].[dbo].[Steve-Bull-306]
  GROUP BY competition
  ORDER BY total_goals DESC;

  -- Number and percentage of Bully's goals scored against different opponents

    SELECT 
    opponent,
     SUM(goals_scored) AS total_goals,
     ROUND(100.0 * SUM(goals_scored) / (SELECT SUM(goals_scored) FROM [Steve Bull 306].[dbo].[Steve-Bull-306]), 2) AS percentage_of_goals

  FROM [Steve Bull 306].[dbo].[Steve-Bull-306]
  GROUP BY opponent
  ORDER BY total_goals DESC;




