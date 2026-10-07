function append_csv_row(filename, row)
%{
    * Append one row to a csv file. File handles are kept open between
      calls, because opening a file for every row is extremely slow.
    * Call append_csv_row() with no arguments to close all open files
      (must be done before the files are read or deleted).
%}
    persistent fids
    if isempty(fids)
        fids = containers.Map();
    end

    if nargin == 0
        for k = fids.keys
            fclose(fids(k{1}));
        end
        fids = containers.Map();
        return;
    end

    if ~isKey(fids, filename)
        fids(filename) = fopen(filename, 'a');
    end
    fprintf(fids(filename), [repmat('%.15g,', 1, numel(row)-1), '%.15g\n'], row);
end
