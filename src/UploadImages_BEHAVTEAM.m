function [rwrd_img,Norwd_img,New_rwrd_img,New_nrwrd_img] = UploadImages_BEHAVTEAM(texturecategory)
    % [file_r,path_r] = uigetfile('../data/',{'*';'*.png';'*.jpeg'},'Select the rewarded texture');
    % [file_nr,path_nr] = uigetfile('../data/',{'*';'*.png';'*.jpeg'},'Select the NON rewarded texture');
    switch texturecategory
        case "sl1"
        rwrd_img = im2double(imread('./data/rleaves_train.jpg'));
        Norwd_img = im2double(imread('./data/circles_train.jpg'));
        New_rwrd_img = im2double(imread('./data/rleaves_test.jpg'));
        New_nrwrd_img = im2double(imread('./data/circles_test.jpg'));
        case "sl2"
        rwrd_img = im2double(imread('./data/leaves_train.jpg'));
        Norwd_img = im2double(imread('./data/squares_train.jpg'));
        New_rwrd_img = im2double(imread('./data/leaves_test.jpg'));
        New_nrwrd_img = im2double(imread('./data/squares_test.jpg'));
        case "sl3"
        rwrd_img = im2double(imread('./data/tiles_train.jpg'));
        Norwd_img = im2double(imread('./data/squares_train.jpg'));
        New_rwrd_img = im2double(imread('./data/tiles_test.jpg'));
        New_nrwrd_img = im2double(imread('./data/squares_test.jpg'));
        case "sl4"
        rwrd_img = im2double(imread('./data/tiles_train.jpg'));
        Norwd_img = im2double(imread('./data/paved_train.jpg'));
        New_rwrd_img = im2double(imread('./data/tiles_test.jpg'));
        New_nrwrd_img = im2double(imread('./data/paved_test.jpg'));
        case "gray"
        rwrd_img = im2double(imread('./data/gray.jpg'));
        Norwd_img = im2double(imread('./data/gray.jpg'));
        New_rwrd_img = im2double(imread('./data/gray.jpg'));
        New_nrwrd_img = im2double(imread('./data/gray.jpg'));
    end

    if length(size(rwrd_img))>2
        rwrd_img = im2double(rgb2gray(rwrd_img));
    else
        rwrd_img = im2double(rwrd_img);
    end
    if length(size(Norwd_img))>2
        Norwd_img = im2double(rgb2gray(Norwd_img));
    else
        Norwd_img = im2double(Norwd_img);
    end
    if length(size(New_rwrd_img))>2
        New_rwrd_img = im2double(rgb2gray(New_rwrd_img));
    else
        New_rwrd_img = im2double(New_rwrd_img);
    end
    if length(size(New_nrwrd_img))>2
        New_nrwrd_img = im2double(rgb2gray(New_nrwrd_img));
    else
        New_nrwrd_img = im2double(New_nrwrd_img);
    end
end

