function insertTemplateHeader
% insertTemplate - inserts predefined header template into the active script
%
% Syntax:  insertTemplate
%      
%      call from command line whith the target script open and active
%      template will be inserted after the first line
%     
%
% Inputs:
%    no inputs; 
%
%    template is defined as character array in lines 81-116
%    to change the template change the character array defined by 
%    headerTemplate={sprntf([...
%                       'template'),...
%                       ]};
%    the published version adds my contact information (same as in this
%    header)
%
%    some parts are prepopulated:
%       -) function name (first word) 
%       -) syntax - initialized as a copy of the first line of the function
%               [outputs]=functionName(inputs)
%       -) Date created and last revisions - both prepopulated with the
%               current date
%
%    the footer currently only marks --- END OF CODE ---
%    additional comments etc could be included into this string the same
%    way as for the header
%
% Outputs:
%    no outpus
%
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none

%
% See also: 
% this script was partially inspired by:
% Alexander Mering (2020). Open new editor window with template / header information (https://www.mathworks.com/matlabcentral/fileexchange/43644-open-new-editor-window-with-template-header-information), MATLAB Central File Exchange. Retrieved January 8, 2020.
% 
% header format is adapted from:
% Denis Gilbert (2020). M-file Header Template (https://www.mathworks.com/matlabcentral/fileexchange/4908-m-file-header-template), MATLAB Central File Exchange. Retrieved January 8, 2020.

% Author: J. Benjamin Kacerovsky
% Centre for Research in Neuroscience, McGill University
% email: johannes.kacerovsky@mail.mcgill.ca
% 08-Jan-2020 ; Last revision: 08-Jan-2020 

%------------- BEGIN CODE --------------

% get current active script and convert text to cell array of lines
currentScript=matlab.desktop.editor.getActive;
tempLines=matlab.desktop.editor.textToLines(currentScript.Text);

% get filename to update header template
fname=currentScript.Filename;
idx=find(fname=='/', 1, 'last');
if length(idx)==1
    fname=fname(idx+1:end-2);
end

idx=find(fname=='\', 1, 'last'); % to account for different file paths in different operating systems
if length(idx)==1   
    fname=fname(idx+1:end-2);
end

if isempty(fname)               % this should never come up, but just in case
    fname='FUNCTION_NAME';
end

% get basic syntax to update header template
syn=tempLines{1};
syn=strrep(syn, 'function ', '');

% create header template to be inserted
% modify this string to change header template
headerTemplate={sprintf([
        '%% %s - One line description of what the function or script performs (H1 line)\n',...
        '%% Optional file header info (to give more details about the function than in the H1 line)\n',...
        '%% Optional file header info (to give more details about the function than in the H1 line)\n',...
        '%% Optional file header info (to give more details about the function than in the H1 line)\n',...
        '%% \n',...
        '%% Syntax:  \n',...
        '%%     %s\n',...
        '%% \n',... 
        '%% Inputs:\n',...
        '%%    input1 - Description\n',...
        '%%    input2 - Description\n',...
        '%%    input3 - Description\n',...
        '%% \n',...
        '%% Outputs:\n',...
        '%%    output1 - Description\n',...
        '%%    output2 - Description\n',...
        '%% \n',...
        '%% Example: \n',...
        '%%    Line 1 of example\n',...
        '%%    Line 2 of example\n',...
        '%%    Line 3 of example\n',...
        '%% \n',...
        '%% Other m-files required: none\n',...
        '%% Subfunctions: none\n',...
        '%% MAT-files required: none\n',...
        '%% \n',...
        '%% See also: OTHER_FUNCTION_NAME1,  OTHER_FUNCTION_NAME2\n',...
        '\n',...
        '%% Author: J. Benjamin Kacerovsky\n',...
        '%% Centre for Research in Neuroscience, McGill University\n',...
        '%% email: johannes.kacerovsky@mail.mcgill.ca\n',...
        '%% Created: %s ; Last revision: %s \n',...
        '\n',...
        '%% ------------- BEGIN CODE --------------\n',...
        '\n'], fname, syn, date, date)};        % the current date is automatically added
 
    
% create footer template to be inserted
% standard comments etc could be included here
footerTemplate={sprintf('\n\n%% ------------- END OF CODE --------------\n')};
    
% insert header template as the second cell in the array of text lines
tempLines=[tempLines{1}, headerTemplate, tempLines{2:end}, footerTemplate];

% convert line array bback to text and update the text of the current
% active script
tempLines=matlab.desktop.editor.linesToText(tempLines);
currentScript.Text=tempLines;