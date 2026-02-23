function data = DDT_data_preprocessing(filepath)
    data_raw = readmatrix(filepath);
    data.w = data_raw(:,1);
    data.z = complex(data_raw(:,2),data_raw(:,3));
end 