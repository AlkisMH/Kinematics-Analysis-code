function dat_summary = analyze_single_subject_v2(subjectName,session,pareticArm,task_list,block_list,num_blocks,data_dir,show_fig)

dat_summary = []; %will change this

warning off;
%% 1. Load data for each task on a separate cell in the "data" cell array

%This is because variable naming within the files is not totally consistent.
C3D_DATA = load([data_dir,'C3D_DATA_T',int2str(session),'.mat']);
q = fieldnames(C3D_DATA);
C3D_DATA = getfield(C3D_DATA,q{1});

disp('List of tasks/blocks found in the whole dataset');

[taskString,blockString] = deal(cell(1, length(C3D_DATA)));
block_reset = zeros(1,length(C3D_DATA));

for nC3D = 1:length(C3D_DATA)
    taskString{nC3D} = C3D_DATA(nC3D).c3d(1).EXPERIMENT.TASK_PROGRAM;
    blockString{nC3D} = C3D_DATA(nC3D).c3d(1).EXPERIMENT.TASK_PROTOCOL;
    
    %check if task was reset during a block, so to exclude it
    for k = 1:length(C3D_DATA(nC3D).c3d)
        if any(strcmp(C3D_DATA(nC3D).c3d(k).EVENTS.LABELS,'TASK_RESET'))
            disp(['Block skipped due to task reset: ' taskString{nC3D},' ',blockString{nC3D},' at trial ',int2str(k)]);
            block_reset(nC3D) = 1;
            continue;
        end
    end
    if ~block_reset(nC3D),disp(['Filename: ' C3D_DATA(nC3D).filename{:} ' ' taskString{nC3D} ' ' blockString{nC3D}]); end
end

data = cell(1,length(task_list));

for i_task = 1:length(task_list)
    n_total_blocks = num_blocks{i_task};
    cs_total_blocks = [0 cumsum(n_total_blocks)];
    data{i_task} = cell(1,sum(n_total_blocks));
    
    for i_block = 1:length(block_list{i_task})
        i_ = find(strcmp(blockString,block_list{i_task}{i_block})&~block_reset,n_total_blocks(i_block),'last');
        for nC3D = i_
            data{i_task}{cs_total_blocks(i_block)+nC3D-i_(1)+1} = C3D_DATA(nC3D).c3d;
        end
    end
end

clear C3D_DATA taskString blockString;

%% 2. Run analysis functions and compile desired data for each task

%note that, within the rest of the code, I'm using i_block differently than
%in part 1

angles = [NaN 0:45:315 NaN];
if show_fig, figure; end
for i_task = 1:length(task_list)
    if isempty(data{i_task})
        disp(['Missing task: ' task_list{i_task}]);
        continue;
    end
    [mvtDir_all,rwdDir_all] = deal(cell(1,3));
    %ok, I know this is ridiculous
    i_blockName = [];
    for i = 1:length(num_blocks{i_task})
        i_blockName = [i_blockName, i*ones(1,num_blocks{i_task}(i))];
    end
    block_list_complete = block_list{i_task}(i_blockName);

    for i_block = 1:length(data{i_task})
        if isempty(data{i_task}{i_block}), continue; end
        block_data = data{i_task}{i_block};
        taskName = task_list{i_task};
        blockName = block_list_complete{i_block};
        nTrials = length(block_data);
        [mvtDirections,mvtDirections_mid,rwdDirections,idealDirections,trial_times,rotation] = deal(NaN(1,nTrials));
        
            switch taskName
                
                %%%% Simple Reaching Task %%%%
                case{'CenterOut_Meret','CenterOut_PaLaS'}
                    parFlag = strcmp(blockName,'SRT_Paretic');
                    reachData=[];
                    offset_i_block = [0 0 2 2];
                    if show_fig, subplot(2,4,i_block+offset_i_block(i_block)); hold on; end
                    
                    for nt = 1:nTrials;
                        %Mine data for desired variables
                        [fs,trialNum,tpNum,st,et,rotn,rxnTime,trialEnd,resultString] = pullVar(block_data(nt));
                        if strcmp(resultString,'STUCK')
                            continue %skipping trials that were repeated
                        end

                        [hxy_offset,etxy_offset] = trajCalc(block_data(nt),st,et,trialEnd,pareticArm,parFlag);
                        [etTheta,mTheta,rTheta] = thetaCalc(hxy_offset,etxy_offset,et);
                        [res]=findResult(resultString);
                        
                        rd = cat(2,trialNum,tpNum,st,et,rotn,rxnTime,etTheta,rTheta,mTheta,res);
                        reachData = cat(1,reachData,rd);
                        
                        mvtDirections(nt) = rTheta;
                        mvtDirections_mid(nt) = mTheta;
                        idealDirections(nt) = angles(et);
                        
                        %Plot trajectories
                        if show_fig,
                            colors_ = 'mbrcmbrcm';
                            plot(hxy_offset(:,1),hxy_offset(:,2),colors_(et)); axis equal;
                        end
                    end
                    if show_fig,
                        t = 0:0.01:2*pi;
                        plot(0.05*cos(t),0.05*sin(t),'k--');
                        plot(0.1*cos(t),0.1*sin(t),'k--');
                        xlabel('x(m)'); ylabel('y(m)');
                        if parFlag == 1
                            title(['Paretic arm, block ',int2str(2-mod(i_block,2))]);
                        else
                            title(['Non-Paretic arm, block ',int2str(2-mod(i_block,2))]);
                        end
                    end
                    
                    %calculate variance (or MSE?) for each reach direction
                    y = reshape(mvtDirections_mid,[],8);
                    y(y>180) = y(y>180)-360; y(y<-180) = y(y<-180)+360;
                    var_by_direction = var(y);
                    MSE_by_direction = sum(y.^2)/size(y,2);
                    
                    %                 subplot(2,4,i_block+4);
                    %                 ax(1) = polar([angles(2:end-1) 0]*pi/180,[var_by_direction var_by_direction(1)],'b.-');
                    %                 hold on;
                    %                 ax(2) = polar([angles(2:end-1) 0]*pi/180,[MSE_by_direction MSE_by_direction(1)],'r.-');
                    %                 legend(ax,'Variance','MSE');
                    %                 best_dir = angles(find(MSE_by_direction==min(MSE_by_direction))+1);
                    %                 xlabel('Variance per movement direction');
                    %                 if i_block == 1
                    %                     title(['Non-Paretic arm, best dir ',int2str(best_dir),'^{\circ}']);
                    %                 else
                    %                     title(['Paretic arm, best dir ',int2str(best_dir),'^{\circ}']);
                    %                 end
                    %                 axis off;
                    
                    %Sort reachData by trial number then save matrix and trajectory figure
                    reachData = sortrows(reachData,1);
                    reachData = (reachData(:,2:end));
                    dat_summary.reachData_SRT{i_block} = reachData;
                    
                    %%%%% Use-dependent task %%%%
                case{'CenterOut_UDL'}
                    parFlag = strncmp(blockName,'UDL_Par',7);
                    reachData=[];
                    jets = jet(25);
                    i = 1;
                    for nt = 1:nTrials;
                        %Mine data for desired variables
                        [fs,trialNum,tpNum,st,et,rotn,rxnTime,trialEnd,resultString] = pullVar(block_data(nt));
                        if strcmp(resultString,'STUCK')
                            continue  %skipping trials that were repeated
                        end
                        [hxy_offset,etxy_offset] = trajCalc(block_data(nt),st,et,trialEnd,pareticArm,parFlag);
                        [etTheta,~,rTheta] = thetaCalc(hxy_offset,etxy_offset,et);
                        [res]=findResult(resultString);
                        
                        rd = cat(2,trialNum,tpNum,st,et,rotn,rxnTime,etTheta,rTheta,res);
                        reachData = cat(1,reachData,rd);
                        mvtDirections(nt) = rTheta;
                        idealDirections(nt) = angles(et);
                        
                    end
                    
                    %Ensure mvtDirections are in the [-180,180] range
                    mvtDirections(mvtDirections>180) = mvtDirections(mvtDirections>180)-360;
                    mvtDirections(mvtDirections<-180) = mvtDirections(mvtDirections<-180)+360;
                    
                    trained_direction = idealDirections(1);
                    tested_direction = idealDirections(end);
                    tested_direction_results = mvtDirections(idealDirections==tested_direction);
                    
                    %if i_block == 1, figure; end
                    if show_fig
                        subplot(2,4,i_block+2);
                        if trained_direction>tested_direction
                            %so that a bias towards the trained direction is positive
                            tested_direction_results = -tested_direction_results;
                        end
                        plot(tested_direction_results,'.-');
                        ylim([-12 12]);
                        grid on;
                        xlabel('Testing trial number'); ylabel('UDL bias (degrees)');
                        text(2,10,['Variance at trained dir:',num2str(var(mvtDirections(idealDirections==trained_direction)))]);
                        if i_block == 1
                            title('Non-Paretic arm');
                        else
                            title('Paretic arm');
                        end
                    end
                    
                    %Sort reachData by trial number then save matrix and trajectory figure
                    reachData = sortrows(reachData,1);
                    reachData = (reachData(:,2:end));
                    dat_summary.reachData_UDL{i_block} = reachData;
                    
                    %%%% Reinforcement Learning Task %%%%
                case{'CenterOut_CLRStroke','CenterOut_PaLaS_CLR'}
                    parFlag = 1;
                    thetaVec_old = zeros(10,1);
                    reachData=[];
                    included_CLR = ones(1,nTrials);
                    
                    for nt = 1:nTrials;
                        %Mine data for desired variables
                        [fs,trialNum,tpNum,st,et,rotn,rxnTime,trialEnd,resultString] = pullVar(block_data(nt));
                        if strncmp(resultString,'TOO_SLOW',8)||strncmp(resultString,'TOO_FAST',8)||strncmp(resultString,'STUCK',5)
                            included_CLR(nt) = 0;
                            continue %skipping trials that were repeated
                        end
                        [hxy_offset,etxy_offset] = trajCalc(block_data(nt),st,et,trialEnd,pareticArm,parFlag);
                        [etTheta,~,rTheta] = thetaCalc(hxy_offset,etxy_offset,et);
                        [thetaMean,thetaVec_old] = thetameanCalc(rTheta,trialNum,thetaVec_old);
                        [res]=findResult(resultString);
                        
                        rd = cat(2,trialNum,tpNum,st,et,rotn,rxnTime,etTheta,rTheta,res,thetaMean);
                        reachData = cat(1,reachData,rd);
                        mvtDirections(nt) = rTheta;
                        rwdDirections(nt) = etTheta-rotn;
                        
                        %Plot trajectories
                        %                 if rotn == 0
                        %                     plot(hxy_offset(:,1),hxy_offset(:,2),'b-')
                        %                 else
                        %                     plot(hxy_offset(:,1),hxy_offset(:,2),'r-')
                        %                 end
                    end
                    
                    %Ensure mvtDirections are in the [-180,180] range
                    mvtDirections(mvtDirections>180) = mvtDirections(mvtDirections>180)-360;
                    mvtDirections(mvtDirections<-180) = mvtDirections(mvtDirections<-180)+360;
                    
                    mvtDir_all{i_block} = mvtDirections(included_CLR==1);
                    rwdDir_all{i_block} = rwdDirections(included_CLR==1);
                    
                    if i_block == 3
                        block_ends = [0 cumsum(cellfun(@length,mvtDir_all))];
                        colors_ = lines;
                        if show_fig
                            subplot(2,4,[3 4]); hold on;
                            for k = 1:3
                                plot(block_ends(k)+1:block_ends(k+1),rwdDir_all{k},'k');
                                plot(block_ends(k)+1:block_ends(k+1),mvtDir_all{k},'.','color',colors_(k,:));
                            end
                            xlabel('Trial number'); ylabel('Movement direction (degrees)'); title('Reinforcement learning task');
                        end;
                    end
                    
                    reachData = sortrows(reachData,1);
                    reachData = (reachData(:,2:end));
                    dat_summary.reachData_CLR{i_block} = reachData;
                    
                    %%%% Adaptation task %%%%
                case{'CentreOut_Meret_Adap','CenterOut_Amanda','CenterOut_PaLaS_VMR'}
                    reachData=[];
                    for nt = 1:nTrials;
                        %Mine data for desired variables
                        try
                            [fs,trialNum,tpNum,st,et,rotn,rxnTime,trialEnd,resultString,timeStamp] = pullVar(block_data(nt));
                        catch
                            continue;
                        end
                        if strncmp(resultString,'TOO_SLOW',8)||strncmp(resultString,'TOO_FAST',8)||strncmp(resultString,'STUCK',5)
                            %only record time
                            trial_times(nt) = datenum(timeStamp);
                            continue %skipping trials that were repeated
                        end
                        [hxy_offset,etxy_offset] = trajCalc(block_data(nt),st,et,trialEnd,pareticArm,parFlag);
                        [etTheta,rTheta,~] = thetaCalc(hxy_offset,etxy_offset,et);
                        [thetaMean,thetaVec_old] = thetameanCalc(rTheta,trialNum,thetaVec_old);
                        [res]=findResult(resultString);
                        
                        rd = cat(2,trialNum,tpNum,st,et,rotn,rxnTime,etTheta,rTheta,res,thetaMean);
                        reachData = cat(1,reachData,rd);
                        mvtDirections(nt) = rTheta;
                        rwdDirections(nt) = etTheta;
                        trial_times(nt) = datenum(timeStamp);
                        rotation(nt) = rotn;
                        
                        %Plot trajectories
                        %                 if rotn == 0
                        %                     plot(hxy_offset(:,1),hxy_offset(:,2),'b-')
                        %                 else
                        %                     plot(hxy_offset(:,1),hxy_offset(:,2),'r-')
                        %                 end
                    end
                    %mvtDirections in the [-180,180] range
                    mvtDirections(mvtDirections>180) = mvtDirections(mvtDirections>180)-360;
                    mvtDirections(mvtDirections<-180) = mvtDirections(mvtDirections<-180)+360;

                    %sort data by time (so I correctly bin)
                    block_direction_data = sortrows([trial_times' rwdDirections' mvtDirections' rotation'],1);
                    %%block_direction_data(isnan(block_direction_data(:,3)),:) = [];
                    
                    mvtDir_all{i_block} = block_direction_data(:,3);
                    rwdDir_all{i_block} = block_direction_data(:,2)-block_direction_data(:,4); 
                    
                    %Note: it is not properly cycling through all targets
                    %mvt_dir_per_cycle
                    if i_block == 3
                        if show_fig
                            subplot(4,4,[11 12]); hold on;
                            block_ends = [0 cumsum(cellfun(@length,mvtDir_all))];
                            colors_ = lines;
                            for k = 1:3
                                t_ = block_ends(k)+1:block_ends(k+1);
                                i_ = ~isnan(rwdDir_all{k});
                                plot(t_(i_),rwdDir_all{k}(i_),'k-');
                                plot(t_,mvtDir_all{k},'.','color',colors_(k,:));
                            end
                            xlabel('Trial number'); ylabel('Movement direction (degrees)'); title('VMR learning task');
                            
                            subplot(4,4,[15 16]); hold on;
                            [mvtDir_all_bin,rwdDir_all_bin] = deal(cell(1,3));
                            for k = 1:3
                                %pad with NaNs to bin
                                d_ = length(mvtDir_all{k});
                                q_ = 8*ceil(d_/8)-d_;
                                mvtDir_all_bin{k} = nanmedian(reshape([mvtDir_all{k};NaN(q_,1)],8,[]));
                                rwdDir_all_bin{k} = nanmedian(reshape([rwdDir_all{k};NaN(q_,1)],8,[]));
                            end
                            block_ends = [0 cumsum(cellfun(@length,mvtDir_all_bin))];
                            colors_ = lines;
                            for k = 1:3
                                plot(block_ends(k)+1:block_ends(k+1),rwdDir_all_bin{k},'k-');
                                plot(block_ends(k)+1:block_ends(k+1),mvtDir_all_bin{k},'color',colors_(k,:));
                            end
                            xlabel('Bin number'); ylabel('Movement direction (degrees)'); title('VMR learning task');
                        end
                    end
                    
                    reachData = sortrows(reachData,1);
                    reachData = (reachData(:,2:end));
                    dat_summary.reachData_VMR{i_block} = reachData;
                    
                    %%%%%%%%%%%%%%%%%%%%%%%%%%% Sanity Check %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                otherwise
                    msg = 'Error: taskName indicated is not found in list of tasks for analysis';
            end
    end
end
