--INSERT INTO channel(channel_id, name) VALUES (1, 'uno:DHT_HT');
INSERT INTO channel(name,smpl_mode_id,grp_id,retent_val) VALUES ( 'DQ:CHL:Tout',1,1,9999);
INSERT INTO channel(name,smpl_mode_id,grp_id,retent_val) VALUES ( 'DQ:CHL:ChSetPointRB',1,1,9999);
INSERT INTO channel(name,smpl_mode_id,grp_id,retent_val) VALUES ( 'DQ:CHL:HPSetPointRB',1,1,9999);
INSERT INTO channel(name,smpl_mode_id,grp_id,retent_val) VALUES ( 'DQ:CHL:PexpV',1,1,9999);
INSERT INTO channel(name,smpl_mode_id,grp_id,retent_val) VALUES ( 'DQ:CHL:Pout',1,1,9999);
INSERT INTO channel(name,smpl_mode_id,grp_id,retent_val) VALUES ( 'DQ:CHL:Tevap',1,1,9999);
INSERT INTO channel(name,smpl_mode_id,grp_id,retent_val) VALUES ( 'DQ:CHL:TexpV',1,1,9999);


--UPDATE channel SET smpl_per=1 WHERE channel_id < 100;
--UPDATE channel SET smpl_mode_id=2 WHERE channel_id < 100;
--UPDATE channel SET grp_id=1 WHERE channel_id < 100;
--UPDATE channel SET retent_val=9999 WHERE channel_id < 100;
