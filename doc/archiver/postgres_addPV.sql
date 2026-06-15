--INSERT INTO channel(name,smpl_mode_id,grp_id,retent_val) VALUES ( 'DQ:CHL:Tout',1,1,9999);
--INSERT INTO channel(name,smpl_mode_id,grp_id,retent_val) VALUES ( 'DQ:CHL:ChSetPointRB',1,1,9999);
--INSERT INTO channel(name,smpl_mode_id,grp_id,retent_val) VALUES ( 'DQ:CHL:PexpV',1,1,9999);
--INSERT INTO channel(name,smpl_mode_id,grp_id,retent_val) VALUES ( 'DQ:CHL:Pref_hp',1,1,9999);
--INSERT INTO channel(name,smpl_mode_id,grp_id,retent_val) VALUES ( 'DQ:CHL:Pref_lp',1,1,9999);
--INSERT INTO channel(name,smpl_mode_id,grp_id,retent_val) VALUES ( 'DQ:CHL:Tevap',1,1,9999);
--INSERT INTO channel(name,smpl_mode_id,grp_id,retent_val) VALUES ( 'DQ:CHL:TexpV',1,1,9999);
--
--INSERT INTO channel(name,smpl_mode_id,grp_id,retent_val) VALUES ( 'DQ:CHL:RelayStatus1_Alarm',1,1,9999);
--INSERT INTO channel(name,smpl_mode_id,grp_id,retent_val) VALUES ( 'DQ:CHL:RelayStatus1_WaterPump',1,1,9999);
--INSERT INTO channel(name,smpl_mode_id,grp_id,retent_val) VALUES ( 'DQ:CHL:RelayStatus2_CondensingFan',1,1,9999);
INSERT INTO channel(name,smpl_mode_id,grp_id,retent_val,smpl_per) VALUES ( 'DQ:CHL:MachineStatus_Standby',1,1,9999,1);



--UPDATE channel SET smpl_per=1 WHERE channel_id < 100;
--UPDATE channel SET smpl_mode_id=2 WHERE channel_id < 100;
--UPDATE channel SET grp_id=1 WHERE channel_id < 100;
--UPDATE channel SET retent_val=9999 WHERE channel_id < 100;
--UPDATE channel SET name=Pcir1 WHERE channel_id < 8;
--DELETE FROM channel where channel_id = 9;
--DELETE FROM sample where channel_id = 9;
