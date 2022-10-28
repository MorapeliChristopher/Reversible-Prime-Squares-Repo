

//_________________________________________________________________________________________
// The following code displays reversible prime squares
// names: M.C khalala
// Student Number: 202002857
// email: christopherkhalala434@gmail.com
//________________________________________________________________________________________
 
/*

We call a number a reversible prime square if:
• It is not a palindrome, and
• It is the square of a prime, and Its reverse is also the square of a prime.
*/
#include <stdio.h>
#include <stdbool.h>
#include<math.h>

					// F U N T I O N   D E C L A R A T I O N S
int reverse(int prime);
bool prime_generator(int prime);
bool palindrome_cheker(int prime);
bool is_square(long prime);
void print_results();
// =======================================================================================================================

// 										DRIVER FUNCTION

//=======================================================================================================================

int main()
{
	int num1,num2,num3; // temporary variables declarations to pass to the control function
	print_results(num1, num2, num3);
	return 0;
}



// =========================================================================================================================

// 									F U N C T I O N   I M P L E M E N T A T I O N S

//==========================================================================================================================

// *****************************************************************************************************************

// SEARCH FOR A REVERSE SQUARE PRIME

//******************************************************************************************************************

int reverse(int prime)
{
	int rev;
	int reverse = 0;
	while(prime != 0)
	{
		rev = (prime % 10);
		reverse = (reverse * 10) + rev;
		prime = prime / 10;
	}
	return reverse;
}

// *****************************************************************************************************************

// CHECKS FOR PRIME NUMBERS

//******************************************************************************************************************

bool prime_generator(int prime)
{
	bool is_Prime = true;
	
	if(prime == 0 || prime == 1 )
	{
		is_Prime=false;
	}
	
	for(int i = 2; i <= (prime) / 2; i++)
	{
		if(prime % i == 0)
		{
			is_Prime=false;
			break;
		}
		
	}
	return is_Prime;
}


// *****************************************************************************************************************

// FUNCTION TO CHECK FOR PALINDROMES

//******************************************************************************************************************

bool palindrome_cheker(int prime)
{
	bool is_Paledrome = true;
	if(reverse(prime) == prime)
	{
		is_Paledrome = false;
	}
	return is_Paledrome;
}





// *****************************************************************************************************************

// CHECKS WHETHER THE PRIME NUMBER IS A SQUARE

//******************************************************************************************************************

bool is_square(long prime)
{
    for(int i = 1; (i * i) <= prime; i++)
    {
        if((prime % i == 0) && (prime / i == i))
        {
            return true;
        }
    }
    return false;
}

// *****************************************************************************************************************

// VOID FUNCTION TO CALL OTHER FUNCTIONS AND PRINT THE REVERSIBLE SQUARE PRIMES

//******************************************************************************************************************

void print_results(int num1, int num2, int num3)
{
	
	
	int i = 0; // initialization for loop control
	while(i >= 0)
	{
		num2 = reverse(i); // assign the reverse of i to the temp variable num2

        if(is_square(i) == true && is_square(num2) == true) 
        {
            num1 = sqrt(i);
            num3 = sqrt(num2);

            if(prime_generator(num1) == 1 && prime_generator(num3))
            {
                if(palindrome_cheker(i))
                {
                    printf("%d \n",i);
                    int j;
                    j++;
                    if(j==10)
                    {
                    	break;
					}
                }

            }
        }
		i++;
	}	
}
