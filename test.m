function [] = test(features, evectors, images, meanface, filenames, num_images)
[fname, fpath] = uigetfile({'*.jpg'}, 'Select image for testing');
input_image = imresize(rgb2gray(imread(strcat(fpath, fname))), [80 80]);
feature_vec = evectors' * (double(input_image(:)) - meanface);
similarity_score = arrayfun(@(n) 1 / (1 + norm(features(:,n) - feature_vec)), 1:num_images);

[match_score, match_ix] = max(similarity_score);

if match_score >= 0.3
    figure, imshow([input_image reshape(images(:,match_ix), [80 80])]);
    title(sprintf('matches %s, score %f', filenames(match_ix).name, match_score));
else
    fprintf('No match found');
end
% display the result

end