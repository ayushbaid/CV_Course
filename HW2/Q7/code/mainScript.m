% Image aligment

angleRange = -60:1:60;
transRange = -12:1:12;

% angleRange = 1;
% transRange = 1;

M = length(angleRange);
N = length(transRange);

%% Part 1: Barbara image and its negative

img1 = im2double(imread('../data/barbara.png'));
img2 = im2double(imread('../data/negative_barbara.png'));

img1 = imresize(img1,0.5);
img2 = imresize(img2,0.5);

img2_corrupt = CreateCorruptImage(img2,28.5,-2,true(1));

figure(1)
imshow(img2);
title('Target Image');

figure(2)
imshow(img2_corrupt);
title('Corrupt Image');


JointEntropy=zeros(M,N);

for i=1:M
    disp(i);
    for j=1:N
        candidateImg = CreateCorruptImage(img1,angleRange(i),transRange(j),false(1));
        [~,JointEntropy(i,j)]=GetJointEntropy(img1,candidateImg);
    end
end


figure(3);
surf(transRange,angleRange,JointEntropy);
title('Joint Entropy');

figure(4);
imagesc(transRange,angleRange,JointEntropy);
title('Joint Entropy');

[tempVal,tempIndex] = min(JointEntropy);
[~,jMin]=min(tempVal);
iMin = tempIndex(jMin);


disp('Estimated angle - ');
disp(-angleRange(iMin));

disp('Estimated translation - ');
disp(-transRange(jMin));


alignedImage = CreateCorruptImage(img2_corrupt,-angleRange(iMin),-transRange(jMin),false(1));
figure(5);
imshow(alignedImage);



