pTab = readtable('plagueDat.csv','ReadVariableNames',1);
dates = pTab.Properties.VariableNames;
med = pTab(1:end,12:end);
med = table2array(med);
med(med == 0) = nan;
med = array2table(med);
pTab(1:end,12:end) = med;
for i = 1:74
gb = geobubble(pTab,'Lat','Long_','SizeVariable',dates(12+i)); 
pause(.125);
end