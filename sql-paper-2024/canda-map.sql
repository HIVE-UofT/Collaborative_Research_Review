SELECT c.pid,
    regexp_split_to_array(m1.data ->> 'Modalities'::text, '["'']+[, ]*["'']+'::text) AS modalities,
    regexp_split_to_array(m2.data ->> 'Modalities'::text, '["'']+[, ]*["'']+'::text) AS modalities2,
    ARRAY( SELECT DISTINCT unnest(array_cat(regexp_split_to_array(m1.data ->> 'Modalities'::text, '["'']+[, ]*["'']+'::text), 
		regexp_split_to_array(m2.data ->> 'Modalities'::text, '["'']+[, ]*["'']+'::text))) AS unnest) AS combined_modalities
   FROM canada c
     LEFT JOIN m1 ON m1.pid = c.pid
     LEFT JOIN m2 ON m2.pid = c.pid
     LEFT JOIN perplexity pp ON pp.pid = c.pid
     LEFT JOIN perplexity2 pp2 ON pp2.pid = c.pid
     LEFT JOIN mm ON mm.pid = c.pid
  WHERE (c.data ->> 'Abstract'::text) IS NOT NULL
    and (jsonb_array_length(c.countries) = 1)
  	AND ((m1.data ->> 'Patient_Level_Data'::text) = 'true'::text OR 
	  	(m2.data ->> 'Patient_Level_Data'::text) = 'true'::text) AND 
		  ((((pp2.data -> 'Data Collection Method'::text) ->> 'Patient Level Data'::text)::boolean) = true OR mm."m_PLD" = true)
		  AND c.countries @> '"Canada"'::jsonb
		 ;