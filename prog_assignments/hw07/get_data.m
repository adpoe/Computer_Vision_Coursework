function [ train, test ] = get_data( scenes_dir, training_pct )

scenes_listing = dir(scenes_dir);

data = [];

for i = (1 : length(scenes_listing))
    
    scene_entry = scenes_listing(i);
       
    % For every scene folder...
    if scene_entry.isdir
        
        % If the folder isn't '..' or '.'
        if ~strcmp(scene_entry.name, '.') && ~strcmp(scene_entry.name, '..')
            
            scene_dir = [scenes_dir '/' scene_entry.name];
            listing = dir(scene_dir);
            
            % For every file within the given scene folder
            for j = (1 : length(listing))
                
                % Check to make sure the file isn't a .db file or a
                % directory
                if ~listing(j).isdir && strcmp('.jpg', listing(j).name(length(listing(j).name) - 3: length(listing(j).name)))
                    im_path = [scene_dir '/' listing(j).name];
                    data_struct = struct('path', im_path, 'category', scene_entry.name);
                    data = [data; data_struct];
                end
            end
        end
    end
end

 shuffled_data=data(randperm(length(data)));

 data_len = length(shuffled_data);
 
 train = shuffled_data(1 : int64(data_len * training_pct));
 test = shuffled_data(int64(data_len * training_pct) : data_len);
 

 
end

