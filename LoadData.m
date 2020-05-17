function [DataAll,Target]=LoadData()
FolderBase='./Batch2/';
files=dir(FolderBase);
DataVIS=[];
DataNIR=[];
Target=[];
for i=3:numel(files)
    sub1=[FolderBase files(i).name];
    files2=dir(sub1);
    for j=3:numel(files2)
        sub2_VIS=[sub1 '/' files2(j).name '/VIS'];
        sub2_NIR=[sub1 '/' files2(j).name '/NIR'];
        
        sub2_VIS_DIR=dir(sub2_VIS);
        sub2_NIR_DIR=dir(sub2_NIR);
        for k=3:numel(sub2_VIS_DIR)
            FileName=[sub2_VIS '/' sub2_VIS_DIR(k).name];
            ReadTemp= xlsread(FileName);
            ReadTemp=ReadTemp(:,1:6);
            [idx,C] = kmeans(ReadTemp,3);
            %%
%             a=size(ReadTemp);
%             r1=floor((a(1)/2)-1);
%             r2=floor((a(1)/2)+1);
%             ReadTemp=ReadTemp(r1:r2,1:6);
%                        
            %%
            DataVIS=[DataVIS; C];
          
        end
        for k=3:numel(sub2_NIR_DIR)
           FileName=[sub2_NIR '/' sub2_NIR_DIR(k).name];
            ReadTemp= xlsread(FileName);
             ReadTemp=ReadTemp(:,1:6);
            [idx,C] = kmeans(ReadTemp,3);
            %%
%             a=size(ReadTemp);
%             r1= floor(a(1)/2)-1;
%             r2= floor(a(1)/2)+1;
%             ReadTemp=ReadTemp(r1:r2,1:6);
            
            %%
             DataNIR=[DataNIR; C];
             
             Target=[Target ;(i-2)*ones(size(C,1),1)];
        end
        
    end
end



% DataNIR=table2array(DataNIR(:,1:6));
% DataVIS=table2array(DataVIS(:,1:6));
DataAll=[DataVIS DataNIR];

end

