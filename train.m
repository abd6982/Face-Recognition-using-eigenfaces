function [features, evectors, images, meanface, filenames, num_images] = train()
input_dir = 'D:\Workspace\Project\images';
filenames = dir(fullfile(input_dir, '*.jpg'));
num_images = numel(filenames);
images(6400,num_images) = 0;
for i = 1:num_images
    image = fullfile(input_dir, filenames(i).name);
    img = rgb2gray(imread(image));
    img = imresize(img,[80 80]);
    images(:,i) = img(:);
end
meanface = mean(images,2);
shifted_images = images - repmat(meanface, 1, num_images);
[evectors, ~, ~] = pca(images');
num_eigenfaces = 20;
evectors = evectors(:, 1:num_eigenfaces);
features = evectors' * shifted_images;
try
    data = load('eigen.mat');
    database = [data.database; evectors];
    save('eigen.mat', database);
catch
    newfile = matfile('eigen.mat', 'Writable', true);
    newfile.database = evectors;
end
end