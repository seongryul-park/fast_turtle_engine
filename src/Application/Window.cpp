#define GLFW_INCLUDE_VULKAN
#include <GLFW/glfw3.h>

#include "Application/Window.h"

namespace Graphics
{
    Window::Window(const Window_Props& props)
    {
        Init(props);
    }

    Window::~Window()
    {
        Shutdown();
    }

    void Window::Init(const Window_Props& props)
    {
        glfwInit();

        glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);
        glfwWindowHint(GLFW_RESIZABLE, GLFW_FALSE);

        m_Window = glfwCreateWindow(props.Width, props.Height, props.Title.c_str(), nullptr, nullptr);
    }

    void Window::Shutdown()
    {
        glfwDestroyWindow(m_Window);
        glfwTerminate();
    }
}