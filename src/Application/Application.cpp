#define VK_USE_PLATFORM_WIN32_KHR
#include <volk.h>

#include "Application/Application.h"
#include "Application/Window.h"

namespace Graphics
{
    Application::Application()
    {
        m_window = std::make_unique<Window>(Window_Props{});
    }

    void Application::Run()
    {

    }
} // namespace Graphics
