#include "org.c"

int defineMain(int argc, char *argv[])
{
	if (argc < 3) {
		printf("Supply arguments for the define command.\n");
		exit(1);
	}

	char * name = argv[2];

	extern char load_path[256];
	FILE * pFile = fopen(load_path, "r");
	org_entry entry = getTopLevelEntry(name, pFile);
	fclose(pFile);

	return 0;
}
