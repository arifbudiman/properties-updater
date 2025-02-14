# Background

Sometimes I need to modify the value of specific set of keys in a very large Java properties file for an application that is hosted on multiple Windows servers, where [sed](https://www.gnu.org/software/sed/manual/sed.html) is not available. This script was created to reduce manual find-and-replace work that needs to be done on every server.

# Limitations

The following are not implemented in this script because I don't have a need for them yet.

- Per spec, there are 3 delimiting characters: equal ('='), colon (':') and whitespace (' ', '\t' and '\f'). This script only address the most common one: equal ('=').
- This script does not address multiple-line values. To this day, I've never seen them.

# Caution

Always verify the end result, e.g., with a diff tool of your choice (WinMerge, BeyondCompare, or at least [FC](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/fc)).

# Usage

This script is not (yet) parameterized, so just adjust the following values:

- `$originalFileName`
- `$keyAndTargetValuePairs`

and execute it. At the end of the execution, two files will be created:

- backup.&lt;yyyy-MM-dd_HHmmss&gt;.&lt;originalFilename&gt; (a backup of the original Java properties file)
- staged.&lt;yyyy-MM-dd_HHmmss&gt;.&lt;originalFilename&gt; (the updated Java properties file)
