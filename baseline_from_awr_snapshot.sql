--Step-1:

exec dbms_sqltune.create_sqlset(sqlset_name => 'bgkzscg36nd5r_sqlset',description => 'sqlset opus');
----------------------------------------------------------------------------------------------------------
--Step-2:

DECLARE
   baseline_ref_cur   DBMS_SQLTUNE.SQLSET_CURSOR;
BEGIN
   OPEN baseline_ref_cur FOR
      SELECT VALUE (p)
        FROM TABLE (DBMS_SQLTUNE.SELECT_WORKLOAD_REPOSITORY (
                             120589,
                             120590,
                          'sql_id='
                       || CHR (39)
                       || 'bgkzscg36nd5r'
                       || CHR (39)
                       || ' and plan_hash_value=1392603843',
                       NULL,
                       NULL,
                       NULL,
                       NULL,
                       NULL,
                       NULL,
                       'ALL')) p;

   DBMS_SQLTUNE.LOAD_SQLSET ('bgkzscg36nd5r_sqlset', baseline_ref_cur);
END;
/

-------------------------------------------------------------------------------------------------------
--Step-3:

DECLARE
    my_int   PLS_INTEGER;
BEGIN
    my_int :=
        DBMS_SPM.load_plans_from_sqlset (
           sqlset_name    => 'bgkzscg36nd5r_sqlset',
           basic_filter   => 'sql_id=''bgkzscg36nd5r''',
  sqlset_owner => 'SUATG',
  fixed => 'YES',
  enabled => 'YES');
  DBMS_OUTPUT.PUT_line(my_int);
  end;
/

-------------------------------------------------------------------------------------------------------
--Step-4:
select inst_id,sql_text,sql_id,plan_hash_value from SYS.gV_$SQLAREA t
where sql_id = 'bgkzscg36nd5r';
------------------------------------Purge--------------------------------------------------------------

select distinct inst_id,
                'exec DBMS_SHARED_POOL.PURGE (''' || address || ',' ||
                hash_value || ''', ''C'');' purge_script
  from gv$sqlarea
where sql_id = 'bgkzscg36nd5r'
order by inst_id asc;
-----------------------------------------------------------------------------------------------------
Fixleme:
-------------
declare
i number;
begin
  i := dbms_spm.alter_sql_plan_baseline(sql_handle      => 'SQL_68b17a315574ade4',
                                   plan_name       => 'SQL_PLAN_6jcbu65ar9bg4d30e5117',
                                   attribute_name  => 'FIXED',
                                   attribute_value => 'YES');

                                                                      
                                   
end;


select * from dba_sql_plan_baselines order by created desc;
