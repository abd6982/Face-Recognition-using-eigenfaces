fprintf('Face Recognition\n\n');

%Training phase

[features, evectors, images, meanface, filenames, num_images] = train();

%Testing phase

test(features, evectors, images, meanface, filenames, num_images);