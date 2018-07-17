#include<stdio.h>
#include<conio.h>
#include<string.h>
struct contact
{
    char name[100], add[100], email[100];
    int num;
}r[100];
int p = 1;
void del()
{
    int i, m, n;
    char x;

    for(i = 1; i <p; i++)
    {
        printf("%d.Name: %s\t\tPhone Number: %d\tAddress: %s\tEmail: %s", i, r[i].name, r[i].num, r[i].add, r[i].email);
    }

    printf("Enter the contact you want to delete: ");
    scanf("%d", &m);

    for(i = 1; i<p; i++)
    {
        if(i == m)
        {
            for( ; i < p - 1; i++)
            {
                strcpy(r[i].name, r[i+1].name);
                strcpy(r[i].add, r[i+1].add);
                r[i].num = r[i+1].num;
                strcpy(r[i].email, r[i+1].email);
            }

            p--;
            break;
        }
    }

    printf("\n\nYou have successfully deleted a contact!\n\n\n Delete more contacts?(Y/N): ");

    fflush(stdin);

    scanf("%c", &x);

    if(x == 'Y'||'y')
    {
        system("cls");
        del();
    }
    else if(x == 'N'||'n')
    {
        system("cls");
        page();
    }
}
void edit()
{
    int i, m, n, b;

    char x;

    if(p - 1 > 0)
    {
        for(i = 1; i < p; i++)
        {
            printf("%d.Name: %s\t\tPhone number: %d\tAddress: %s\tEmail: %s\n\n", i, r[i].name, r[i].num, r[i].add, r[i].email);
        }

        printf("Enter the contact you want to edit: ");
        scanf("%d", &m);
        fflush(stdin);

        system("cls");

        printf("1.Name\n\n2. Phone number\n\n3. Address\n\n4. Email\n\n\n\n");

        printf("Enter the option you want to edit: ");
        scanf("%d", &n);

        fflush(stdin);

        system("cls");


        if(n==1)
        {
            printf("Previous Name: %s\n\n\n", r[m].name);

            printf("Enter new one: ");

            gets(r[m].name);

            printf("\n\n\nYou have successfully edited!\n\n\n");

            printf("Edit more? (Y/N)");
            scanf("%c", &x);
            fflush(stdin);

            if(x == 'Y')
            {
                system("cls");

                edit();
            }
            else
            {
                system("cls");
                page();
            }
        }

        else if(n==2)
        {
            printf("Previous Phone Number: %d\n\n\n", r[m].num);

            printf("Enter new one: ");
            scanf("%d", &r[m].num);

            printf("You have successfully edited!\n\n\n");

            printf("Edit more?(Y/N)");
            scanf("%c", &x);

            fflush(stdin);

            if(x == 'Y')
            {
                system("cls");
                edit();
            }
            else
            {
                system("cls");
                page();
            }
        }
        else if(n==3)
        {
            printf("Privious Address: %s\n\n\n", r[m].add);

            printf("Enter new one: ");

            gets(r[m].add);

            printf("You have successfully edited!\n\n\n");

            printf("Edit more?(Y/N)");
            scanf("%c", &x);

            if(x == 'Y')
            {
                system("cls");
                edit();
            }
            else
            {
                system("cls");
                page();

            }
        }

        else if(n==4)
        {
            printf("Previous Email: %s\n\n\n", r[m].email);

            printf("Enter new ID: ");
            scanf("%d", &r[m].email);


            printf("You have successfully edited!\n\n\n");

            printf("Edit more ???(Y/N)");
            scanf("%c", &x);

            fflush(stdin);

            if(x == 'Y')
            {
                system("cls");
                edit();
            }
            else
            {
                system("cls");
                page();
            }
        }
        else
        {
            printf("Invalid option\n\n\n");

            printf("Do you want to change again?(Y/N)");
            scanf("%c", &x);

            if(x == 'Y')
            {
                system("cls");
                edit();
            }
            else
            {
                system("cls");
                page();
            }
        }
    }
    else
    {
        printf("\n\n\nNo record added.Add some\n\n Press 0 for main menu: ");
        scanf("%d", &b);

        if(b == 0)
        {
            system("cls");
            page();
        }
    }
}
void search()
{
    int i;
    char n, b[100];

        printf("Enter Name number: ");

        gets(b);

        for(i = 1; i < p; i++)
        {
            if(strcmp(b, r[i].name) == 0)
            {
                printf("1.Name: %s\nPhone number: %d\nAddress: %s\nEmail: %s\n\n\n\n\n", r[i].name, r[i].num, r[i].add, r[i].email);
                printf("Are you want to search again(Y/N)!! ");

                scanf("%c", &n);
                fflush(stdin);

                if(n == 'Y'||'y')
                {
                    system("cls");
                    search();
                }
                else if(n == 'N'||'n')
                {
                    system("cls");
                    page();
                }
            }
        }

        printf("Sorry!!!  we do not find anything !!\n\n\n");
        printf("Are you want to search again(Y/N)!! ");

        scanf("%c", &n);
        fflush(stdin);

        if(n == 'Y'||'y')
            {
                system("cls");
                search();
            }
        if(n == 'N'||'n')
            {
                system("cls");
                page();
            }
    }
void view()
{
    int i, m;
    if(p > 1)
    {
        printf("Name\t\t\tPhone number\t\tAddress\t\tEmail\n\n");

        for(i = 1; i < p; i++)
        {
            printf("%d.%s\t\t%d\t%s\t\t%s\n\n", i, r[i].name, r[i].num, r[i].add,r[i].email);
        }

        printf("\n\n\n\n\n\nTotal Contact = %d\t\t\t\t\t\t\t0 for go back main menu: ", p - 1);
        scanf("%d", &m);
        if(m==0)
        {
            system("cls");
            page();
        }
    }
    else
    {
        printf("You did not add any records!\n\n\n");
        printf("Press 0 for go back main menu: ");
        scanf("%d", &m);
        if(m==0)
        {
            system("cls");
            page();
        }
    }
}
void add()
{
    int m = 0, n;

    char x;

    printf("Name: ");

    gets(r[p].name);

    printf("Phone number: ");
    scanf("%d", &r[p].num);
    fflush(stdin);
    printf("Address: ");

    gets(r[p].add);

    printf("Email: ");
    gets(r[p].email);
    fflush(stdin);

    p++;
    printf("\a\n\n\nSuccessfully Added a Contact!\n\n\n");

    printf("Do you want to add more ?? (Y/N)!");
    scanf("%s", &x);
    fflush(stdin);

    if(x == 'N'||'n')
    {
        system("cls");

        page();
    }
    else if(x == 'Y'||'y')
    {
        system("cls");

        add();
    }
}

void page()
{
    int a, b,c;
    printf("\t\t1. Add Contact\n\n");
    printf("\t\t2. View Contact\n\n");
    printf("\t\t3. Search Contact\n\n");
    printf("\t\t4. Edit Contact\n\n");
    printf("\t\t5. Delete Contact\n\n");
    printf("\t\t6. Exit\n\n\n");

    printf("Enter your option(1-6): ");
    scanf("%d", &a);
    fflush(stdin);
    if(a == 1)
    {
        system("cls");

        add();
    }
    else if(a == 2)
    {
        system("cls");

        view();
    }
    else if(a == 3)
    {
        system("cls");

        search();
    }
    else if(a == 4)
    {
        system("cls");
        edit();
    }
    else if(a == 5)
    {
        system("cls");
        del();
    }
    else if(a == 6)
    {
        system("cls");
        printf("Successfully exit");
        exit(0);
    }
}

int main()
{
    int i = 0;
    char m, pass[10] = "", opass[] = "cse",d;

    printf("\n\n\n\t\t\t>>>>>>>>>>Password Protect<<<<<<<<<\n\n\n");

    while(1)
    {
        m = getch();
        if(m == 13) break;
        pass[i] = m;
        printf("*");
        i++;
    }

   if(strcmp(pass, opass) == 0)
    {

        system("cls");
        page();

    }
    else
    {
        printf("\n\n\n  \t\t\tPassword does not match !!\n\n\n");

        printf("Try again?(Y/N): ");
        scanf("%c", &d);
        if(d == 'Y'||'y')
        {
            system("cls");
            main();
        }
        else
            return 0;
    }

    return 0;
}
