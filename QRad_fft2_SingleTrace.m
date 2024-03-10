% This function computes the second term of Eq. (6), which is an estimate of how eye movements and stimulus dynamics redistribute power in space-time.  
%
% It relies on two fundamental assumptions which must be always taken into account, and must be used with caution:
%     1) eye movements do not depend on the external image
%     2) the power of the external image is spatially symmetric
% 
% INPUT:
%       Kval = vector of spatial frequencies (cycles/degree)
%       Nw = Number of temporal frequency samples
%       KRadAng = vector of angles
%       Xe, Ye =  eye movement trace (arcmin)
%       Win = window for Fourier Transform
%       Gt = gain for image luminance (represented by contrast) as a function of time: Img(x) * G(t)
%
% OUTPUT:
%       PS = a 2D power spectrum
%


function PS  = QRad_fft2_SingleTrace(Kval, Nw, KRadAng, Xe, Ye, Win, Gt)

	if(nargin() < 7), Gt = 1; end
 
	Ns = length(Xe);       % Number of eye movement samples
	Nk = length(Kval);     % Number of spatial frequency samples

	PS = zeros(Nw, Nk);
	 
	for SpatialFrequency = 1:length(Kval)
	    kk = Kval(SpatialFrequency);
	    for kAng = KRadAng
	        kx = kk*cos(kAng);  ky = kk*sin(kAng);
	        eTerm = Gt .* exp(-i*2*pi*(kx*Xe+ky*Ye)/60);
	        fAll = fft(eTerm'.*Win',Nw);
	        PS(:, SpatialFrequency) = PS(:, SpatialFrequency) + (abs(fAll).^2);
	    end
	end

	PS = PS/length(KRadAng);
end
