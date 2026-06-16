import duckdb
con = duckdb.connect("eai.duckdb")

con.sql("""
    copy mart_collaboration_modes
    to 'exports/mart_collaboration_modes.csv'
    (header, delimiter ',', quote '"', force_quote *)
""")

con.sql("""
    copy mart_task_platform_comparison
    to 'exports/mart_task_platform_comparison.csv'
    (header, delimiter ',', quote '"', force_quote *)
""")

con.close()
print("Re-exported both marts with full quoting")
