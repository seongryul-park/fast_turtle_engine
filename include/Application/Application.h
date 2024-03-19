#pragma once
#include <memory>

namespace Graphics
{
    class Window;

    class Application
    {
        public:
            static Application& Instance(){static Application instance; return instance;}

            void Run();
        private:
            Application();

            std::unique_ptr<Window> m_window;
    };
}