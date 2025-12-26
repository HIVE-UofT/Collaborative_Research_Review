SELECT 
    country,
    COUNT(*) AS collaboration_count
FROM (
	
	SELECT 
		jsonb_array_elements(c.countries) AS country
	FROM public.canada c
	left join m1 on m1.pid=c.pid
	left join m2 on m2.pid=c.pid
	left join perplexity pp on pp.pid=c.pid
	left join public.perplexity2 pp2 on pp2.pid=c.pid
	left join mm on mm.pid=c.pid
	
	WHERE 
		c.data ->> 'Abstract' IS Not NULL AND
		(m1.data->>'Patient_Level_Data' = 'true' OR m2.data->>'Patient_Level_Data' = 'true') 
		and 
		((pp2.data->'Data Collection Method'->>'Patient Level Data')::boolean = true
	 	or mm."m_PLD" = true)

) AS expanded_countries
GROUP BY 
    country
ORDER BY 
    collaboration_count DESC
LIMIT 11;
	


-- SELECT 
-- 	-- count(*) total, 
-- 	-- SUM((jsonb_array_length(c.countries) = 1)::int) AS domestic_count,
-- 	-- SUM((jsonb_array_length(c.countries) > 1)::int) AS international

-- 	c.year,  -- Include the year column in the SELECT statement
--     COUNT(*) AS total, 
--     SUM((jsonb_array_length(c.countries) = 1)::int) AS domestic_count,
--     SUM((jsonb_array_length(c.countries) > 1)::int) AS international

	
-- 	-- c.countries
-- 	-- pp.data->'Total Dataset Size'->>'Number of Records/Samples' AS pp_num_records_samples,
--  --    pp.data->'Data Collection Method'->>'Type' AS pp_data_collection_type,
--  --    pp.data->'Data Collection Method'->>'Source of Data' AS pp_data_source,
--  --    pp.data->'Data Collection Method'->>'Timeframe of Data Collection' AS pp_data_collection_timeframe,
--  --    pp.data->'Data Modalities'->>'Type of Data' AS pp_data_type,
--  --    pp.data->'Data Modalities'->>'Combination of Modalities' AS pp_combination_of_modalities,
--  --    pp.data->'Data Modalities'->>'Data Format' AS pp_data_format,
--  --    pp.data->'Number of Features in Datasets'->>'Feature Count' AS pp_feature_count,
--  --    pp.data->'Number of Features in Datasets'->>'Feature Types' AS pp_feature_types,
--  --    pp.data->'Number of Features in Datasets'->>'Feature Selection Methods' AS pp_feature_selection_methods,
--  --    pp.data->'AI Methods'->>'Specific Algorithms' AS pp_ai_specific_algorithms,
--  --    pp.data->'AI Methods'->>'Model Architecture' AS pp_ai_model_architecture,
--  --    pp.data->'AI Methods'->>'Training Techniques' AS pp_ai_training_techniques,
--  --    pp.data->'AI Methods'->'Performance Metrics'->>'Accuracy' AS pp_ai_accuracy,  -- Corrected this line
--  --    pp.data->'Number of Collaborators'->>'Number of Institutions' AS pp_num_institutions,
--  --    pp.data->'Number of Collaborators'->>'Geographical Distribution' AS pp_geographical_distribution,
--  --    pp.data->'Number of Collaborators'->>'Roles' AS pp_collaborator_roles,
--  --    pp.data->'Data Privacy Techniques'->>'Privacy-Preserving Methods' AS pp_privacy_preserving_methods,
--  --    pp.data->'Data Privacy Techniques'->>'Compliance with Regulations' AS pp_compliance_with_regulations,
--  --    pp.data->'Data Privacy Techniques'->>'Data Anonymization' AS pp_data_anonymization,
--  --    pp.data->'Data Heterogeneity'->>'Source Diversity' AS pp_source_diversity,
--  --    pp.data->'Data Heterogeneity'->>'Population Diversity' AS pp_population_diversity,
--  --    pp.data->'Data Heterogeneity'->>'Consistency Across Datasets' AS pp_consistency_across_datasets,
--  --    pp.data->'Data Sharing and Collaboration Mechanisms'->>'Platforms Used' AS pp_platforms_used,
--  --    pp.data->'Data Sharing and Collaboration Mechanisms'->>'Collaboration Models' AS pp_collaboration_models,
--  --    pp.data->'Data Sharing and Collaboration Mechanisms'->>'Data Accessibility' AS pp_data_accessibility,
--  --    pp.data->'Ethical Considerations'->>'Ethical Approvals' AS pp_ethical_approvals,
--  --    pp.data->'Ethical Considerations'->>'Informed Consent' AS pp_informed_consent,
--  --    pp.data->'Ethical Considerations'->>'Bias Mitigation' AS pp_bias_mitigation
	
-- FROM public.canada c
-- left join m1 on m1.pid=c.pid
-- left join m2 on m2.pid=c.pid
-- left join perplexity pp on pp.pid=c.pid
-- left join public.perplexity2 pp2 on pp2.pid=c.pid
-- left join mm on mm.pid=c.pid

-- WHERE 
-- 	c.data ->> 'Abstract' IS Not NULL AND
-- 	(m1.data->>'Patient_Level_Data' = 'true' OR m2.data->>'Patient_Level_Data' = 'true') 
-- 	and 
-- 	((pp2.data->'Data Collection Method'->>'Patient Level Data')::boolean = true
--  	or mm."m_PLD" = true)


-- GROUP BY 
--     c.year  -- Group by the year column
-- ORDER BY 
--     c.year;  -- Optional: Order by year
