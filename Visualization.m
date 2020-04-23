pTab = readtable('plagueDat2.csv','ReadVariableNames',1);
dates = pTab.Properties.VariableNames;
med = pTab(1:end,12:end);
med = table2array(med);
med(med == 0) = nan;
med = array2table(med);
pTab(1:end,12:end) = med;
len = size(med,2);
for i = 1:len-1
gb = geobubble(pTab,'Lat','Long_','SizeVariable',dates(12+i)); 
pause(.125);
end