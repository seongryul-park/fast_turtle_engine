#pragma once
#include <string>

struct GLFWwindow;

namespace Graphics 
{
    struct Window_Props;

	class Window
	{
	public:
        Window(const Window_Props& props);
        ~Window();
        
		inline unsigned int GetWidth() const { return m_Data.Width; }
		inline unsigned int GetHeight() const { return m_Data.Height; }
		inline void* GetNativeWindow() { return m_Window; }

	private:
        void Init(const Window_Props& props);
        void Shutdown();
	private:
		GLFWwindow* m_Window;

		struct WindowData
		{
			std::string Title;
			unsigned int Width;
			unsigned int Height;
			bool VSync;
		};

		WindowData m_Data;
	};

	struct Window_Props
	{
		std::string Title;
		unsigned int Width;
		unsigned int Height;

		Window_Props(const std::string& title = "Turtle Engine",
			unsigned int width = 1280,
			unsigned int height = 720)
			: Title(title), Width(width), Height(height)
		{	}
	};
}