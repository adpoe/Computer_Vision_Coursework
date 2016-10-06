function [ p2 ] = apply_homography( p1, H )
%APPLY_HOMOGRAPHY Pick a point in image one (p1) and use the computed
%   homography, H, to compute where it "lands" in the second image.
%   Must convert back to homogenous coordinates.
    p2 = H * horzcat(p1, 1)';
end

