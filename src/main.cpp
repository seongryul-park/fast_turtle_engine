#include <iostream>
#include <stdexcept>
#include <cstdlib>

#include <Application/Application.h>

int main() 
{
    try 
    {
        //  const Graphics::Window window(Graphics::Window_Props{});

        
        
    } catch (const std::exception& e) 
    {
        std::cerr << e.what() << std::endl;
    
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}
