function L=del2(U,h,options)
%zsc.del2	Improved version of MATLAB del2
%	zsc.del2(U,*h,ExtrapolationMethod="linear") is the same as
%	del2(U,*h)*2*ndims(U) but tolerates any input numbers of h.
%	Additionally, one does not need to swap the first two elements of h to
%	convert ij to xy. Finally, you can select different ways to calculate
%	the edge point: linear, nearest, neumann, dirichlet.
%
%	See also del2

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		U{mustBeNumeric}
	end
	arguments(Input,Repeating)
		h(1,:){mustBeNumeric}
	end
	arguments(Input)
		options.ExtrapolationMethod(1,1)string{mustBeMember(options.ExtrapolationMethod,["linear","nearest","neumann","dirichlet"])}="linear"
	end
	arguments(Output)
		L{mustBeNumeric}
	end
	if isscalar(h)
		ndims=minndims(U);
		h=repmat(h,[1,ndims]);
	else
		ndims=max(minndims(U),numel(h));
		h=paddata(h,ndims,FillValue={1});
	end
	loc=h;
	for k=1:ndims
		if isscalar(loc{k})
			loc{k}=loc{k}*(1:size(U,k));
		end
	end
	perm=[2:ndims,1];
	L=zeros(size(U),like=U);
	for k=1:ndims
		n=size(U,1);
		x=loc{k}(:);
		h=diff(x);
		g=zeros(size(U),like=U);
		if n>2
			g(2:n-1,:)=(diff(U(2:n,:))./h(2:n-1)-diff(U(1:n-1,:))./h(1:n-2))./(h(2:n-1)+h(1:n-2));
		end
		switch options.ExtrapolationMethod
			case "linear"
				if n>3
					g(1,:)=g(2,:)*(h(1)+h(2))/h(2)-g(3,:)*h(1)/h(2);
					g(n,:)=g(n-1,:)*(h(n-1)+h(n-2))/h(n-2)-g(n-2,:)*h(n-1)/h(n-2);
				elseif n==3
					g(1,:)=g(2,:);
					g(n,:)=g(n-1,:);
				else
					g(1,:)=0;
					g(n,:)=0;
				end
			case "nearest"
				if n>2
					g(1,:)=g(2,:);
					g(n,:)=g(n-1,:);
				else
					g(1,:)=0;
					g(n,:)=0;
				end
			case "neumann"
				g(1,:)=0;
				g(n,:)=0;
			case "dirichlet"
				if n>1
					g(1,:)=(U(2,:)-U(1,:))/h(1)/2;
					g(n,:)=(U(n-1,:)-U(n,:))/h(n-1)/2;
				else
					g(1,:)=0;
					g(n,:)=0;
				end
		end
		L=L+zsc.ipermute(g,[k:ndims,1:k-1]);
		U=zsc.permute(U,perm);
	end
	L=L*2;
end